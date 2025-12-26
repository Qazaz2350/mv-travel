import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  /// Navigate after delay
  Future<void> navigateToNext(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;

    Navigator.pushReplacementNamed(context, '/onboarding');
  }
}
// class SplashViewModel extends ChangeNotifier {
//   /// Navigate to the next screen after a short delay
//   Future<void> navigateToNext(BuildContext context) async {
//     // Small delay for splash screen
//     await Future.delayed(const Duration(seconds: 1));

//     // Check if the context is still mounted
//     if (!context.mounted) return;

//     // Get the current user
//     final user = FirebaseAuth.instance.currentUser;

//     // Navigate based on whether the user is logged in
//     if (user == null) {
//       Nav.push(context, OnboardingScreen());
//       // Navigator.pushReplacementNamed(context, '/onboarding');
//     } else {
//       Nav.push(context, HomePageView());
//     }
//   }
// }
