import 'package:flutter/material.dart';
import 'package:mvtravel/model/filters_model.dart';

class JobFilterViewModel extends ChangeNotifier {
  final JobFilterModel _filter = JobFilterModel();

  // Text Controllers
  final TextEditingController keywordsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryMinController = TextEditingController();
  final TextEditingController salaryMaxController = TextEditingController();

  // Options
  final List<String> distanceOptions = [
    '5 miles',
    '10 miles',
    '15 miles',
    '25 miles',
    '50 miles',
  ];

  final List<String> salaryTypeOptions = [
    'Annual',
    'Monthly',
    'Weekly',
    'Daily',
    'Hourly',
  ];

  final List<String> jobTypeOptions = [
    'Full Time',
    'Part Time',
    'Contract',
    'Temporary',
    'Internship',
  ];

  // Getters
  String get selectedDistance => _filter.selectedDistance;
  String get selectedSalaryType => _filter.selectedSalaryType;
  String get selectedJobType => _filter.selectedJobType;

  // Setters
  void setDistance(String value) {
    _filter.selectedDistance = value;
    notifyListeners();
  }

  void setSalaryType(String value) {
    _filter.selectedSalaryType = value;
    notifyListeners();
  }

  void setJobType(String value) {
    _filter.selectedJobType = value;
    notifyListeners();
  }

  // Dispose
  void disposeControllers() {
    keywordsController.dispose();
    locationController.dispose();
    salaryMinController.dispose();
    salaryMaxController.dispose();
  }
}
