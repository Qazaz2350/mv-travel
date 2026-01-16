import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvtravel/commen/country_list.dart';

class PhoneNumberViewModel extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();

  // ✅ Default selected country code
  String selectedCountryCode = '+92';
  String phoneDialCode = '+92'; // store dial code separately

  List<Country> get countries => countryList;

  void changeCountry(String value) {
    selectedCountryCode = value; // for full phone number
    phoneDialCode = value; // for Firestore storage
    notifyListeners();
  }

  /// Save phone number + dial code to Firestore
  Future<void> savePhoneNumber() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw 'User not signed in';

      final String phone = phoneController.text.trim();

      // 🔴 Validation
      if (phone.isEmpty) throw 'Please enter phone number';
      if (!RegExp(r'^[0-9]+$').hasMatch(phone))
        throw 'Phone number must contain digits only';
      if (phone.length < 7 || phone.length > 15)
        throw 'Enter a valid phone number';

      // Combine country code + phone for full number
      final String fullPhone = '$selectedCountryCode$phone';

      // ✅ Save to Firestore, merge to prevent overwriting other fields
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'phoneNumber': fullPhone,
        'phoneDialcode': phoneDialCode,
      }, SetOptions(merge: true));
    } catch (e) {
      // rethrow as string for UI
      throw e.toString();
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
