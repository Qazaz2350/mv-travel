import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mvtravel/model/onboarding/investment_details_model.dart';

class InvestmentDetailsViewModel extends ChangeNotifier {
  final amountController = TextEditingController();
  InvestmentData investmentData = InvestmentData();
  bool isLoading = false;
  bool isPickingFile = false;
  String? errorMessage;

  // ---------------- Pick document & upload to Firebase Storage ----------------
  Future<void> pickDocument() async {
    isPickingFile = true;
    notifyListeners();

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (result == null) {
        isPickingFile = false;
        notifyListeners();
        return; // user canceled
      }

      String fileName = result.files.single.name;

      // Mobile: use File(path)
      File? file;
      if (result.files.single.path != null) {
        file = File(result.files.single.path!);
      }

      String downloadUrl = '';

      if (file != null) {
        // Upload to Firebase Storage
        Reference ref = FirebaseStorage.instance.ref().child(
          'investment_documents/$fileName',
        );
        UploadTask uploadTask = ref.putFile(file);

        TaskSnapshot snapshot = await uploadTask;
        downloadUrl = await snapshot.ref.getDownloadURL();

        print('Document uploaded successfully: $downloadUrl');
      }

      // Add document to the model
      investmentData.uploadedDocuments.add(
        UploadedDocument(
          fileName: "investment_documents/",
          fileUrl: downloadUrl, // ✅ Save URL
        ),
      );
    } catch (e) {
      print('Error picking/uploading document: $e');
      errorMessage = 'Document upload failed';
    } finally {
      isPickingFile = false;
      notifyListeners();
    }
  }

  void removeDocument(int index) {
    investmentData.uploadedDocuments.removeAt(index);
    notifyListeners();
  }

  void updateInvestmentType(InvestmentType? type) {
    investmentData.investmentType = type;
    notifyListeners();
  }

  // ---------------- SAVE TO FIREBASE ----------------
  Future<bool> saveInvestmentDetails() async {
    isLoading = true;
    notifyListeners();

    // Bind amount
    investmentData.amount =
        double.tryParse(amountController.text.replaceAll(',', '')) ?? 0;

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      // Prepare uploaded documents data
      List<Map<String, dynamic>> docs = investmentData.uploadedDocuments
          .map((e) => {'investmentDocument': e.fileName, 'fileUrl': e.fileUrl})
          .toList();

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'investmentDetails': {
          'amount': investmentData.amount,
          'investmentType': investmentData.investmentType?.name,
          'uploadedDocuments': docs, // ✅ Save documents with URL
          'createdAt': FieldValue.serverTimestamp(),
        },
      }, SetOptions(merge: true));

      errorMessage = null;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
