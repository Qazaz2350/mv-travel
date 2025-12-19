import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvtravel/model/onboarding/investment_details_model.dart';

class InvestmentDetailsViewModel extends ChangeNotifier {
  final amountController = TextEditingController();
  InvestmentData investmentData = InvestmentData();
  bool isLoading = false;
  bool isPickingFile = false;
  String? errorMessage;

  // ---------------- Pick document (UNCHANGED) ----------------
  Future<void> pickDocument() async {
    isPickingFile = true;
    notifyListeners();

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (result != null && result.files.single.name.isNotEmpty) {
        investmentData.uploadedDocuments.add(
          UploadedDocument(fileName: result.files.single.name),
        );
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isPickingFile = false;
    notifyListeners();
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

    // if ((investmentData.amount ?? 0) <= 0 ||
    //     investmentData.investmentType == null) {
    //   errorMessage = "Please fill all required fields.";
    //   isLoading = false;
    //   notifyListeners();
    //   return false;
    // }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'investmentDetails': {
            'amount': investmentData.amount,
            'investmentType': investmentData.investmentType?.name,
            'createdAt': FieldValue.serverTimestamp(), // ✅ TIMESTAMP
          },
        },
        SetOptions(merge: true), // keep previous data
      );

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
