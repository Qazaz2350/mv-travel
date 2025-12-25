// import 'package:flutter/material.dart';

// class SignUpViewModel extends ChangeNotifier {
//   final formKey = GlobalKey<FormState>();

//   final fullNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   bool isPasswordVisible = false;
//   bool isConfirmPasswordVisible = false;
//   bool agreeToTerms = false;

//   // Validators
//   String? validateFullName(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter your full name';
//     return null;
//   }

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter your email';
//     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//       return 'Enter a valid email address';
//     }
//     return null;
//   }

//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter password';
//     if (value.length < 6) return 'Password must be at least 6 characters';
//     return null;
//   }

//   String? validateConfirmPassword(String? value) {
//     if (value == null || value.isEmpty) return 'Please confirm password';
//     if (value != passwordController.text) return 'Passwords do not match';
//     return null;
//   }

//   void togglePasswordVisibility() {
//     isPasswordVisible = !isPasswordVisible;
//     notifyListeners();
//   }

//   void toggleConfirmPasswordVisibility() {
//     isConfirmPasswordVisible = !isConfirmPasswordVisible;
//     notifyListeners();
//   }

//   void toggleAgreeToTerms(bool? value) {
//     agreeToTerms = value ?? false;
//     notifyListeners();
//   }

//   bool submit() {
//     if (!formKey.currentState!.validate()) return false;
//     if (!agreeToTerms) return false; // Terms not checked
//     // Form is valid and terms accepted
//     return true;
//   }

//   void disposeControllers() {
//     fullNameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:mvtravel/model/onboarding/signup_model.dart';
import 'package:mvtravel/services/firebase_service.dart';

class SignUpViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  final SignUpModel _model = SignUpModel();

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Password visibility
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Agree to terms
  bool get agreeToTerms => _model.agreeToTerms;
  set agreeToTerms(bool value) {
    _model.agreeToTerms = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  // Sign up
  Future<bool> signUp() async {
    if (!formKey.currentState!.validate() || !_model.agreeToTerms) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final user = await _firebaseService.signUp(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      return user != null;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
