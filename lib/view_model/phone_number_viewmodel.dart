import 'package:flutter/material.dart';

class PhoneNumberViewModel extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = '+92';

  List<String> countryCodes = ['+92', '+1', '+44', '+91'];

  void changeCountry(String value) {
    selectedCountryCode = value;
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
