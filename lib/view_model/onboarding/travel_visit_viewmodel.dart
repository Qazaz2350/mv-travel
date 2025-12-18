import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvtravel/model/onboarding/travel_visa_model.dart';

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
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  /// 🔹 Convert to Map with Firestore Timestamps
  Map<String, dynamic> toMap() {
    return {
      'startDate': _model.startDate != null
          ? Timestamp.fromDate(_model.startDate!)
          : null,
      'endDate': _model.endDate != null
          ? Timestamp.fromDate(_model.endDate!)
          : null,
      'reason': _model.reason ?? '',
      'estimatedBudget': _model.estimatedBudget ?? '',
    };
  }

  /// 🔹 Save Travel Visa details to Firebase
  Future<void> saveToFirebase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'travelVisa': toMap(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint('Error saving travel visa: $e');
    }
  }
}
