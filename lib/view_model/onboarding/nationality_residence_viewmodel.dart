import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvtravel/commen/country_list.dart';
// import '../models/country_list.dart'; // 🔹 import the reusable list

class NationalityResidenceViewModel extends ChangeNotifier {
  Country? selectedNationality;
  Country? selectedResidence;

  /// 🔹 Use the reusable country list
  List<Country> countries = countryList;

  /// Setters
  void setNationality(Country? country) {
    selectedNationality = country;
    notifyListeners();
  }

  void setResidence(Country? country) {
    selectedResidence = country;
    notifyListeners();
  }

  /// 🔥 Firebase-ready map
  /// 🔥 Firebase-ready map including name and flag info
  Map<String, dynamic> toMap() {
    return {
      'nationality': {
        'code': selectedNationality?.code,
        'name': selectedNationality?.name,
        'dial': selectedNationality?.dialCode,
        // flag can be generated from code, so storing code is enough
      },
      'residence': {
        'code': selectedResidence?.code,
        'name': selectedResidence?.name,
        'dial': selectedResidence?.dialCode,
      },
    };
  }

  /// ✅ Validation getters
  bool get isNationalityValid => selectedNationality != null;
  bool get isResidenceValid => selectedResidence != null;

  /// ✅ Overall validation
  bool get isValid => isNationalityValid && isResidenceValid;

  /// ✅ Save selected nationality & residence to Firebase
  Future<void> saveToFirebase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(toMap(), SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint('Error saving nationality & residence: $e');
    }
  }
}
