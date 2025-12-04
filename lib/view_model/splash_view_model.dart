import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  /// Navigate after delay
  Future<void> navigateToNext(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;

    Navigator.pushReplacementNamed(context, '/onboarding');
  }
}
