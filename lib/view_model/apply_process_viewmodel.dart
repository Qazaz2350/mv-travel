// ignore_for_file: invalid_use_of_protected_member, dead_code, invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvtravel/model/apply_process_model.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApplyProcessViewModel extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  final ApplyProcessModel model = ApplyProcessModel();

  int get currentStep => model.currentStep;
  File? get photoFile => model.photoFile;
  File? get passportFile => model.passportFile;

  void nextStep() {
    if (model.currentStep < 3) {
      model.currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (model.currentStep > 0) {
      model.currentStep--;
      notifyListeners();
    }
  }

  void removePhoto() {
    model.photoFile = null;
    notifyListeners();
  }

  void removePassport() {
    model.passportFile = null;
    notifyListeners();
  }

  Future<void> pickFromGallery(bool isPhoto) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (isPhoto) {
        model.photoFile = File(image.path);
      } else {
        model.passportFile = File(image.path);
      }
      notifyListeners();
    }
  }

  Future<void> pickFromCamera(bool isPhoto) async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (isPhoto) {
        model.photoFile = File(image.path);
      } else {
        model.passportFile = File(image.path);
      }
      notifyListeners();
    }
  }
}

class DetailViewModel extends ChangeNotifier {
  // Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passportController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();

  // Dropdown values
  String? selectedNationality;
  String? selectedVisaType;
  String selectedCountryCode = '+92';

  // File uploads
  File? passportDocument;
  File? photoDocument;

  // Date
  DateTime? selectedDate;

  // Dispose all controllers
  void disposeControllers() {
    fullNameController.dispose();
    emailController.dispose();
    passportController.dispose();
    addressController.dispose();
    phoneController.dispose();
    dobController.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: ColorScheme.light(primary: AppColors.blue2)),
          child: child!,
        );
      },
    );

    if (date != null) {
      selectedDate = date;
      dobController.text =
          '${date.month.toString().padLeft(2, '0')} / ${date.day.toString().padLeft(2, '0')} / ${date.year}';
      notifyListeners();
    }
  }

  // Pick image
  Future<void> pickImage(bool isPassport) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (image != null) {
        if (isPassport) {
          passportDocument = File(image.path);
        } else {
          photoDocument = File(image.path);
        }
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error picking image: $e');
    }
  }

  Future<void> submitForm(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final formData = {
        'visaFullName': fullNameController.text,
        'visaEmail': emailController.text,
        'visaNationality': selectedNationality,
        'visaPassportNumber': passportController.text,
        'visaType': selectedVisaType,
        'addressForVisa': addressController.text,
        'visaBirthDate': selectedDate?.toIso8601String(),
        'visaNumber': phoneController.text,
      };

      // Create a new document under a "visas" subcollection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('visas')
          .add(formData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Keep catch but no validation messages
    }
  }

  // Clear all text fields, dropdowns, files, and date
  void clearForm() {
    fullNameController.clear();
    emailController.clear();
    passportController.clear();
    addressController.clear();
    phoneController.clear();
    dobController.clear();

    selectedNationality = null;
    selectedVisaType = null;
    selectedDate = null;

    passportDocument = null;
    photoDocument = null;

    notifyListeners(); // Rebuild UI after clearing
  }
}

// Payment ViewModel
class PaymentViewModel extends ChangeNotifier {
  final cardNumberController = TextEditingController();
  final nameController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  bool usePayPal = false;

  void togglePayPal() {
    usePayPal = !usePayPal;
    notifyListeners();
  }

  void disposeControllers() {
    cardNumberController.dispose();
    nameController.dispose();
    expiryController.dispose();
    cvvController.dispose();
  }
}

// Formatter for card number
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && (i + 1) != text.length) buffer.write(' ');
    }
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

// Formatter for expiry date
class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.length > 2) {
      final month = text.substring(0, 2);
      final year = text.substring(2);
      final formatted = '$month/$year';
      return newValue.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    return newValue;
  }
}
