import 'package:flutter/material.dart';

class VisaDetailViewModel extends ChangeNotifier {
  int? _expandedIndex;

  int? get expandedIndex => _expandedIndex;

  void toggleFAQ(int index) {
    if (_expandedIndex == index) {
      _expandedIndex = null;
    } else {
      _expandedIndex = index;
    }
    notifyListeners();
  }
}
