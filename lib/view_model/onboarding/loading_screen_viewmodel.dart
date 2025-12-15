import 'package:flutter/material.dart';

class LoadingScreenViewModel extends ChangeNotifier {
  double progress = 0.0;

  // Animation Controller for progress bar will be created in the View
  Future<void> startLoading(Function onComplete) async {
    // Simulate loading
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      progress = i / 100;
      notifyListeners();
    }

    onComplete();
  }
}
