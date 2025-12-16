// lib/view_model/filters_viewmodel.dart
import 'package:flutter/material.dart';
import '../model/filters_model.dart';

class FiltersViewModel extends ChangeNotifier {
  final FiltersModel _model = FiltersModel();

  // Getters
  String get selectedVisaType => _model.selectedVisaType;
  String get selectedCountry => _model.selectedCountry;
  String get selectedRegion => _model.selectedRegion;
  String get selectedRegion2 => _model.selectedRegion2;
  DateTime? get fromDate => _model.fromDate;
  DateTime? get toDate => _model.toDate;
  Set<String> get selectedStatuses => _model.selectedStatuses;

  List<String> get countries => _model.countries;
  List<String> get regions => _model.regions;

  // Actions
  void selectVisaType(String type) {
    _model.selectedVisaType = type;
    notifyListeners();
  }

  void setCountry(String country) {
    _model.selectedCountry = country;
    notifyListeners();
  }

  void setRegion({required bool isFirst, required String region}) {
    if (isFirst) {
      _model.selectedRegion = region;
    } else {
      _model.selectedRegion2 = region;
    }
    notifyListeners();
  }

  void setFromDate(DateTime? date) {
    _model.fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime? date) {
    _model.toDate = date;
    notifyListeners();
  }

  void toggleStatus(String status) {
    if (_model.selectedStatuses.contains(status)) {
      _model.selectedStatuses.remove(status);
    } else {
      _model.selectedStatuses.add(status);
    }
    notifyListeners();
  }

  void clearFilters() {
    _model.reset();
    notifyListeners();
  }

  // For debugging / external use
  FiltersModel snapshot() => _model.copy();
}
