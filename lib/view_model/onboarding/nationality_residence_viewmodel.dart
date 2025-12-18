import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NationalityResidenceViewModel extends ChangeNotifier {
  String? selectedNationality;
  String? selectedResidence;

  /// List of countries with flags
  List<Map<String, String>> countries = [
    {'name': 'Pakistan', 'flag': '🇵🇰'},
    {'name': 'India', 'flag': '🇮🇳'},
    {'name': 'United States', 'flag': '🇺🇸'},
    {'name': 'United Kingdom', 'flag': '🇬🇧'},
    {'name': 'Canada', 'flag': '🇨🇦'},
    {'name': 'Australia', 'flag': '🇦🇺'},
    {'name': 'Germany', 'flag': '🇩🇪'},
    {'name': 'France', 'flag': '🇫🇷'},
    {'name': 'Italy', 'flag': '🇮🇹'},
    {'name': 'Spain', 'flag': '🇪🇸'},
    {'name': 'Brazil', 'flag': '🇧🇷'},
    {'name': 'Mexico', 'flag': '🇲🇽'},
    {'name': 'China', 'flag': '🇨🇳'},
    {'name': 'Japan', 'flag': '🇯🇵'},
    {'name': 'South Korea', 'flag': '🇰🇷'},
    {'name': 'Russia', 'flag': '🇷🇺'},
    {'name': 'Turkey', 'flag': '🇹🇷'},
    {'name': 'Saudi Arabia', 'flag': '🇸🇦'},
    {'name': 'UAE', 'flag': '🇦🇪'},
    {'name': 'Egypt', 'flag': '🇪🇬'},
    {'name': 'South Africa', 'flag': '🇿🇦'},
    {'name': 'Nigeria', 'flag': '🇳🇬'},
    {'name': 'Kenya', 'flag': '🇰🇪'},
    {'name': 'Argentina', 'flag': '🇦🇷'},
    {'name': 'Chile', 'flag': '🇨🇱'},
    {'name': 'Colombia', 'flag': '🇨🇴'},
    {'name': 'Thailand', 'flag': '🇹🇭'},
    {'name': 'Vietnam', 'flag': '🇻🇳'},
    {'name': 'Malaysia', 'flag': '🇲🇾'},
    {'name': 'Indonesia', 'flag': '🇮🇩'},
    {'name': 'Philippines', 'flag': '🇵🇭'},
    {'name': 'Singapore', 'flag': '🇸🇬'},
    {'name': 'New Zealand', 'flag': '🇳🇿'},
    {'name': 'Norway', 'flag': '🇳🇴'},
    {'name': 'Sweden', 'flag': '🇸🇪'},
    {'name': 'Finland', 'flag': '🇫🇮'},
    {'name': 'Netherlands', 'flag': '🇳🇱'},
    {'name': 'Switzerland', 'flag': '🇨🇭'},
    {'name': 'Ireland', 'flag': '🇮🇪'},
    {'name': 'Belgium', 'flag': '🇧🇪'},
  ];

  void setNationality(String? value) {
    selectedNationality = value;
    notifyListeners();
  }

  void setResidence(String? value) {
    selectedResidence = value;
    notifyListeners();
  }

  /// 🔥 Firebase-ready map
  Map<String, dynamic> toMap() {
    return {'nationality': selectedNationality, 'residence': selectedResidence};
  }

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
