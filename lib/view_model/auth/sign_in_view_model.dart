// import 'package:flutter/material.dart';
// import 'package:mvtravel/services/firebase_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignInViewModel extends ChangeNotifier {
//   final FirebaseService _firebaseService = FirebaseService();

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool isPasswordVisible = false;
//   bool isLoading = false;

//   void togglePasswordVisibility() {
//     isPasswordVisible = !isPasswordVisible;
//     notifyListeners();
//   }

//   String? validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return "Please enter your email";
//     }
//     const emailPattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
//     if (!RegExp(emailPattern).hasMatch(value.trim())) {
//       return "Enter a valid email address";
//     }
//     return null;
//   }

//   String? validatePassword(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return "Please enter your password";
//     }
//     if (value.trim().length < 6) {
//       return "Password must be at least 6 characters";
//     }
//     return null;
//   }

//   // ✅ Connect signIn to Firebase
//   Future<void> signIn(
//     VoidCallback onSuccess, {
//     Function(String)? onError,
//   }) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       User? user = await _firebaseService.signIn(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       if (user != null) {
//         onSuccess();
//       }
//     } catch (e) {
//       if (onError != null) onError(e.toString());
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:mvtravel/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Please enter your email";
    const emailPattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
    if (!RegExp(emailPattern).hasMatch(value.trim()))
      return "Enter a valid email address";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty)
      return "Please enter your password";
    if (value.trim().length < 6)
      return "Password must be at least 6 characters";
    return null;
  }

  Future<void> signIn(
    VoidCallback onSuccess, {
    Function(String)? onError,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      User? user = await _firebaseService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user != null) onSuccess();
    } catch (e) {
      if (onError != null) onError(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
