import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvtravel/model/onboarding/work_application_details_model.dart';

class WorkApplicationDetailsViewModel extends ChangeNotifier {
  final WorkApplicationDetailsModel workData = WorkApplicationDetailsModel();

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  bool isLoading = false;
  bool isPickingFile = false;
  String? errorMessage;

  // ---------------- Job Offer ----------------
  void updateJobOfferStatus(bool value) {
    workData.hasJobOffer = value;
    notifyListeners();
  }

  // ---------------- File Picker (UNCHANGED) ----------------
  Future<void> pickOfferLetter() async {
    isPickingFile = true;
    notifyListeners();

    FilePickerResult? result = await FilePicker.platform.pickFiles();

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

  // ---------------- SAVE TO FIREBASE ----------------
  Future<bool> saveWorkDetails() async {
    isLoading = true;
    notifyListeners();

    // Bind text fields
    workData.jobTitle = jobTitleController.text.trim();
    workData.experience = experienceController.text.trim();
    workData.salary = salaryController.text.trim();

    // Simple validation
    if (workData.jobTitle.isEmpty) {
      errorMessage = "Please enter job title";
      isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'workApplication': {
            'jobTitle': workData.jobTitle,
            'experience': workData.experience,
            'hasJobOffer': workData.hasJobOffer,
            'salary': workData.salary,
            'createdAt': FieldValue.serverTimestamp(), // ✅ TIMESTAMP
          },
        },
        SetOptions(merge: true), // ✅ keeps previous onboarding data
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
    jobTitleController.dispose();
    experienceController.dispose();
    salaryController.dispose();
    super.dispose();
  }
}
