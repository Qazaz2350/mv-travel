import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:mvtravel/model/onboarding/investment_details_model.dart';

import 'package:file_picker/file_picker.dart';

class InvestmentDetailsViewModel extends ChangeNotifier {
  final amountController = TextEditingController();
  InvestmentData investmentData = InvestmentData();
  bool isLoading = false;
  bool isPickingFile = false;
  String? errorMessage;

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

  Future<bool> saveInvestmentDetails() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2)); // Simulate API call

    isLoading = false;
    notifyListeners();

    if (investmentData.amount != null &&
        investmentData.investmentType != null) {
      return true;
    } else {
      errorMessage = "Please fill all required fields.";
      return false;
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
