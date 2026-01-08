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
        if (work != null) {
          final offerLetterUrl = work['offerLetterUrl'] as String?;
          final offerLetterFileName =
              work['offerLetterFileName'] as String? ?? 'Job Offer Letter';
          if (offerLetterUrl != null && offerLetterUrl.isNotEmpty) {
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
        final investment = data['investmentDetails'];
        if (investment != null) {
          final uploadedDocs =
              investment['uploadedDocuments'] as List<dynamic>?;
          if (uploadedDocs != null && uploadedDocs.isNotEmpty) {
            for (var doc in uploadedDocs) {
              final fileName =
                  doc['investmentDocument'] ?? 'Investment Document';
              final fileUrl = doc['fileUrl'] ?? '';
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

      // ---------------- User-uploaded Photo & Passport ----------------
      final visaSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('visas')
          .orderBy('createdAt', descending: true)
          .get();

      for (var visaDoc in visaSnapshot.docs) {
        final visaData = visaDoc.data();

        final visaCountry = visaData['visaCountry'] as String?;
        final photoUrl = visaData['photoUrl'] as String?;
        final passportUrl = visaData['passportUrl'] as String?;

        if (photoUrl != null && photoUrl.isNotEmpty) {
          documents.add(
            DocumentItem(
              name: 'Photo',
              url: photoUrl,
              type: 'user',
              visaCountry: visaCountry,
            ),
          );
        }

        if (passportUrl != null && passportUrl.isNotEmpty) {
          documents.add(
            DocumentItem(
              name: 'Passport',
              url: passportUrl,
              type: 'user',
              visaCountry: visaCountry,
            ),
          );
        }
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
