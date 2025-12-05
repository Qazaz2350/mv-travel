import 'package:flutter/material.dart';

class NationalityResidenceViewModel extends ChangeNotifier {
  String? selectedNationality;
  String? selectedResidence;

  List<String> countries = [
    'Pakistan',
    'United States',
    'United Kingdom',
    'India',
  ];

  void setNationality(String? value) {
    selectedNationality = value;
    notifyListeners();
  }

  void setResidence(String? value) {
    selectedResidence = value;
    notifyListeners();
  }
}
