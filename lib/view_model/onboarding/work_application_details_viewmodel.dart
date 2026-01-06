import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvtravel/model/onboarding/work_application_details_model.dart';
// import '../model/onboarding/work_application_details_model.dart';

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

  // ---------------- File Picker & Upload ----------------
  Future<void> pickOfferLetter() async {
    try {
      isPickingFile = true;
      notifyListeners();

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result == null) {
        isPickingFile = false;
        notifyListeners();
        return;
      }

      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;

      // Upload file to Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child(
        'offer_letters/$fileName',
      );
      UploadTask uploadTask = ref.putFile(file);

      // Wait for completion
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save file info in model
      workData.offerLetterFileName = fileName;
      workData.offerLetterUrl = downloadUrl;

      print('File uploaded successfully: $downloadUrl');
    } catch (e) {
      print('Error picking/uploading file: $e');
      errorMessage = 'File upload failed';
    } finally {
      isPickingFile = false;
      notifyListeners();
    }
  }

  void removeOfferLetter() {
    workData.offerLetterFileName = "";
    workData.offerLetterUrl = null;
    notifyListeners();
  }

  // ---------------- Save Work Details ----------------
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

      // Save all work data including offer letter URL
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'workApplication': {
          'jobTitle': workData.jobTitle,
          'experience': workData.experience,
          'hasJobOffer': workData.hasJobOffer,
          'salary': workData.salary,
          'offerLetterFileName': workData.offerLetterFileName,
          'offerLetterUrl': workData.offerLetterUrl,
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
    jobTitleController.dispose();
    experienceController.dispose();
    salaryController.dispose();
    super.dispose();
  }
}
