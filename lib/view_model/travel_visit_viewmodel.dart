import 'package:flutter/material.dart';
import 'package:mvtravel/model/travel_visa_model.dart';

class TravelVisaViewModel extends ChangeNotifier {
  final TravelVisaModel _model = TravelVisaModel();

  TravelVisaModel get model => _model;

  void setStartDate(DateTime date) {
    _model.startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _model.endDate = date;
    notifyListeners();
  }

  void setReason(String reason) {
    _model.reason = reason;
    notifyListeners();
  }

  void setEstimatedBudget(String budget) {
    _model.estimatedBudget = budget;
    notifyListeners();
  }

  bool get canSave => _model.isValid;

  String formatDate(DateTime? date) {
    if (date == null) return 'mm/dd/yyyy';
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }
}
