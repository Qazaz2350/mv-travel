import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Model to represent a document
class DocumentItem {
  final String name; // Descriptive name
  final String url; // File URL
  final String type; // 'work', 'investment', 'user'

  DocumentItem({required this.name, required this.url, required this.type});
}

class DocumentsViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<DocumentItem> documents = [];

  // ------------------------------------------------------------
  // FETCH Work, Investment + User Uploaded Documents
  // ------------------------------------------------------------
  Future<void> fetchDocuments() async {
    isLoading = true;
    errorMessage = null;
    documents.clear();
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final userDocSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = userDocSnapshot.data();

      if (data != null) {
        // ---------------- Work Documents ----------------
        final work = data['workApplication'] as Map<String, dynamic>?;
        if (work != null) {
          final offerLetterUrl = (work['offerLetterUrl'] ?? '').toString();
          final offerLetterFileName =
              (work['offerLetterFileName'] ?? 'Job Offer Letter').toString();
          if (offerLetterUrl.isNotEmpty) {
            documents.add(
              DocumentItem(
                name: offerLetterFileName,
                url: offerLetterUrl,
                type: 'work',
              ),
            );
          }
        }

        // ---------------- Investment Documents ----------------
        final investment = data['investmentDetails'] as Map<String, dynamic>?;
        if (investment != null) {
          final uploadedDocs =
              investment['uploadedDocuments'] as List<dynamic>?;
          if (uploadedDocs != null && uploadedDocs.isNotEmpty) {
            for (var doc in uploadedDocs) {
              if (doc is Map<String, dynamic>) {
                final fileName =
                    (doc['investmentDocument'] ?? 'Investment Document')
                        .toString();
                final fileUrl = (doc['fileUrl'] ?? '').toString();
                if (fileUrl.isNotEmpty) {
                  documents.add(
                    DocumentItem(
                      name: fileName,
                      url: fileUrl,
                      type: 'investment',
                    ),
                  );
                }
              }
            }
          }
        }
      }

      // ---------------- User Uploaded Documents ----------------
      final userDocsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('user_documents')
          .orderBy('createdAt', descending: true)
          .get();

      for (var doc in userDocsSnapshot.docs) {
        final docData = doc.data();
        documents.add(
          DocumentItem(
            name: docData['name'] ?? 'Document',
            url: docData['url'] ?? '',
            type: docData['fileType'] ?? 'user',
          ),
        );
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  // ------------------------------------------------------------
  // PICK IMAGE FROM GALLERY
  // ------------------------------------------------------------
  Future<File?> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // ------------------------------------------------------------
  // PICK DOCUMENT FROM DEVICE
  // ------------------------------------------------------------
  Future<File?> pickDocumentFromDevice() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      );
      if (result == null || result.files.single.path == null) return null;
      return File(result.files.single.path!);
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // ------------------------------------------------------------
  // UPLOAD USER FILE → FIREBASE STORAGE → SAVE TO FIRESTORE
  // ------------------------------------------------------------
  Future<void> uploadUserFile({
    required File file,
    required String name,
    required String fileType,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final extension = file.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$extension';

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_documents')
          .child(user.uid)
          .child(fileName);

      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('user_documents')
          .add({
            'name': name,
            'url': downloadUrl,
            'fileType': fileType,
            'createdAt': FieldValue.serverTimestamp(),
          });

      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  // ------------------------------------------------------------
  // DELETE USER UPLOADED DOCUMENT
  // ------------------------------------------------------------
  Future<void> deleteUserDocument(DocumentItem docItem) async {
    try {
      isLoading = true;
      notifyListeners();

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      // Delete from Firebase Storage
      final storageRef = FirebaseStorage.instance.refFromURL(docItem.url);
      await storageRef.delete();

      // Delete from Firestore
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('user_documents')
          .where('url', isEqualTo: docItem.url)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      // Remove from local list
      documents.removeWhere((d) => d.url == docItem.url);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  // ------------------------------------------------------------
  // DOWNLOAD DOCUMENT AS FILE
  // ------------------------------------------------------------
  Future<File> downloadDocumentAsFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${url.split('/').last}');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}
