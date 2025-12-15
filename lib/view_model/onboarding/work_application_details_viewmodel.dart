
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mvtravel/model/onboarding/work_application_details_model.dart';

class WorkApplicationDetailsViewModel extends ChangeNotifier {
  final WorkApplicationDetailsModel workData = WorkApplicationDetailsModel();

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  bool isLoading = false;
  bool isPickingFile = false;
  String? errorMessage;

  // -----------------------------------------------------
  // Update job offer status
  // -----------------------------------------------------
  void updateJobOfferStatus(bool value) {
    workData.hasJobOffer = value;
    notifyListeners();
  }

  // -----------------------------------------------------
  // File Picker
  // -----------------------------------------------------
  Future<void> pickOfferLetter() async {
    isPickingFile = true;
    notifyListeners();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      workData.offerLetterFileName = result.files.single.name;
    }

    isPickingFile = false;
    notifyListeners();
  }

  void removeOfferLetter() {
    workData.offerLetterFileName = "";
    notifyListeners();
  }

  // -----------------------------------------------------
  // Save Work Details Logic
  // -----------------------------------------------------
  Future<bool> saveWorkDetails() async {
    isLoading = true;
    notifyListeners();

    // Bind data
    workData.jobTitle = jobTitleController.text;
    workData.experience = experienceController.text;
    workData.salary = salaryController.text;

    await Future.delayed(const Duration(seconds: 1));

    if (workData.jobTitle.isEmpty) {
      errorMessage = "Please enter job title";
      isLoading = false;
      notifyListeners();
      return false;
    }

    errorMessage = null;
    isLoading = false;
    notifyListeners();
    return true;
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    experienceController.dispose();
    salaryController.dispose();
    super.dispose();
  }
}
