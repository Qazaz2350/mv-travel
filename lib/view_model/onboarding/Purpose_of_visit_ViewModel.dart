import 'package:flutter/material.dart';
import 'package:mvtravel/model/onboarding/purpose_of_visit_model.dart';

class VisitPurposeViewModel extends ChangeNotifier {
  String? _selectedPurposeId;

  String? get selectedPurposeId => _selectedPurposeId;

  final List<VisitPurpose> purposes = [
    VisitPurpose(
      
      id: 'travel',
      imagePath: 'assets/icon_images/plane.png',
      title: 'Travel Visa',
      description: 'For tourism, family visits, or short-term leisure.',
      
    ),
    VisitPurpose(
      id: 'student',
      imagePath: 'assets/icon_images/internatioanl_student.png',
      title: 'International student',
      description: 'For academic programs or language studies.',
    ),
    VisitPurpose(
      id: 'work',
      imagePath: 'assets/icon_images/Work Visa.png',
      title: 'Work Visa',
      description:
          'For employment, business meetings, or professional activities.',
    ),
    VisitPurpose(
      id: 'investment',
      imagePath: 'assets/icon_images/Investment.png',
      title: 'Investment',
      description: 'For starting a business or making an investment',
    ),
  ];

  void selectPurpose(String purposeId) {
    _selectedPurposeId = purposeId;
    notifyListeners();
  }

  bool isPurposeSelected(String purposeId) {
    return _selectedPurposeId == purposeId;
  }

  bool get canProceed => _selectedPurposeId != null;
}
