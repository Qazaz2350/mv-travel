import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Model to represent a document
class DocumentItem {
  final String name; // Descriptive name
  final String url; // File URL
  final String type; // 'work', 'investment', or 'user'
  final String? visaCountry; // Optional: for user documents linked to a visa

  DocumentItem({
    required this.name,
    required this.url,
    required this.type,
    this.visaCountry,
  });
}

class DocumentsViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<DocumentItem> documents = [];

  /// Fetch Work, Investment, and User-uploaded documents (photo & passport)
  Future<void> fetchDocuments() async {
    isLoading = true;
    errorMessage = null;
    documents.clear();
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      // ---------------- Work & Investment Documents ----------------
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final data = docSnapshot.data();
      if (data != null) {
        // ---------------- Work Documents ----------------
        final work = data['workApplication'];
        if (work != null && work is Map<String, dynamic>) {
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
            print(
              'Work document added: $offerLetterFileName -> $offerLetterUrl',
            );
          }
        }

        // ---------------- Investment Documents ----------------
        final investment = data['investmentDetails'];
        if (investment != null && investment is Map<String, dynamic>) {
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
                  print('Investment document added: $fileName -> $fileUrl');
                }
              }
            }
          }
        }
      }

      // ---------------- User-uploaded Photo & Passport ----------------
      final visaSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('visas')
          .get(); // Removed orderBy in case createdAt doesn't exist

      if (visaSnapshot.docs.isEmpty) {
        print('No visas found for user ${user.uid}');
      }

      for (var visaDoc in visaSnapshot.docs) {
        final visaData = visaDoc.data();
        print('Visa doc id: ${visaDoc.id}, data: $visaData');

        final visaCountry = (visaData['visaCountry'] ?? 'Unknown Visa')
            .toString();
        final photoUrl = (visaData['photoUrl'] ?? '').toString();
        final passportUrl = (visaData['passportUrl'] ?? '').toString();

        if (photoUrl.isNotEmpty) {
          documents.add(
            DocumentItem(
              name: 'Photo',
              url: photoUrl,
              type: 'user',
              visaCountry: visaCountry,
            ),
          );
          print('Photo added: $photoUrl');
        }

        if (passportUrl.isNotEmpty) {
          documents.add(
            DocumentItem(
              name: 'Passport',
              url: passportUrl,
              type: 'user',
              visaCountry: visaCountry,
            ),
          );
          print('Passport added: $passportUrl');
        }
      }

      isLoading = false;
      notifyListeners();
    } catch (e, stack) {
      print('Error fetching documents: $e\n$stack');
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
