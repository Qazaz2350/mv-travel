import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvtravel/model/onboarding/international_students_model.dart';

class InternationalStudentsViewModel extends ChangeNotifier {
  final InternationalStudentsModel model = InternationalStudentsModel();

  List<String> studyLevels = ["Undergraduate", "Graduate", "Postgraduate"];

  // ----------------- Setters -----------------
  void setUniversityName(String value) {
    model.universityName = value;
    notifyListeners();
  }

  void setAdmissionStatus(String value) {
    model.admissionStatus = value;
    notifyListeners();
  }

  void setStudyLevel(String? value) {
    if (value == null) return;
    model.studyLevel = value;
    notifyListeners();
  }

  // ----------------- Map for Firestore -----------------
  Map<String, dynamic> toMap() {
    return {
      'universityName': model.universityName ?? '',
      'admissionStatus': model.admissionStatus ?? '',
      'studyLevel': model.studyLevel ?? '',
    };
  }

  // ----------------- Save to Firebase -----------------
  Future<void> saveToFirebase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'internationalStudent': toMap(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint('Error saving international student info: $e');
    }
  }
}
