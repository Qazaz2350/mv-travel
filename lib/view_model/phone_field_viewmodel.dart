import 'package:flutter/material.dart';

class PhoneFieldViewModel extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();

  String selectedCountryCode = '+92';

  final List<String> countryCodes = [
    '+92',
    '+91',
    '+1',
    '+44',
    '+971',
    '+86',
    '+81',
  ];

  void onCountryCodeChanged(String value) {
    selectedCountryCode = value;
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
