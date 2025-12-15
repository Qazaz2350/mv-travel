import 'package:flutter/material.dart';
import 'package:mvtravel/model/onboarding/international_students_model.dart';

class InternationalStudentsViewModel extends ChangeNotifier {
  final InternationalStudentsModel model = InternationalStudentsModel();

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

  void save() {
    // You can connect API later
    print("SAVED:");
    print(model.universityName);
    print(model.admissionStatus);
    print(model.studyLevel);
  }
}
