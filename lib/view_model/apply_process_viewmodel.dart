// ignore_for_file: invalid_use_of_protected_member, dead_code, invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvtravel/model/apply_process_model.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mvtravel/views/apply_for_visa/app_lists.dart';
import 'package:provider/provider.dart';

class ApplyProcessViewModel extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  final ApplyProcessModel model = ApplyProcessModel();

  int get currentStep => model.currentStep;
  File? get photoFile => model.photoFile;
  File? get passportFile => model.passportFile;

  String? get photoUrl => model.photoUrl;
  String? get passportUrl => model.passportUrl;

  void nextStep(BuildContext context) {
    if (model.currentStep == 0 && model.photoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your photo before proceeding'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (model.currentStep == 1 && model.passportFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your passport before proceeding'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

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
    model.photoUrl = null; // clear URL as well
    notifyListeners();
  }

  void removePassport() {
    model.passportFile = null;
    model.passportUrl = null; // clear URL as well
    notifyListeners();
  }

  Future<void> pickFromGallery(bool isPhoto) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await _handlePickedFile(File(image.path), isPhoto);
    }
  }

  Future<void> pickFromCamera(bool isPhoto) async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await _handlePickedFile(File(image.path), isPhoto);
    }
  }

  /// ✅ Handles both setting local file and uploading to Firebase
  Future<void> _handlePickedFile(File file, bool isPhoto) async {
    if (isPhoto) {
      model.photoFile = file;
      notifyListeners();
      final url = await uploadFileToFirebase(file, 'photos');
      if (url != null) {
        model.photoUrl = url;
        notifyListeners();
      }
    } else {
      model.passportFile = file;
      notifyListeners();
      final url = await uploadFileToFirebase(file, 'passports');
      if (url != null) {
        model.passportUrl = url;
        notifyListeners();
      }
    }
  }

  Future<String?> uploadFileToFirebase(File file, String folder) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}';
      final ref = FirebaseStorage.instance.ref().child(
        '$folder/${user.uid}/$fileName',
      );
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading file: $e');
      return null;
    }
  }
}

// ------------------- The rest of your code stays exactly the same -------------------

class DetailViewModel extends ChangeNotifier {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passportController = TextEditingController();
  final addressController = TextEditingController();
  final phonecode = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();

  String? selectedNationality;
  String? selectedVisaType;
  String selectedCountryCode = AppLists.countries.first['code']!;

  File? passportDocument;
  File? photoDocument;

  DateTime? selectedDate;

  void disposeControllers() {
    fullNameController.dispose();
    emailController.dispose();
    passportController.dispose();
    addressController.dispose();
    phoneController.dispose();
    dobController.dispose();
    phonecode.dispose();
  }

  String? validateFullName() =>
      fullNameController.text.trim().isEmpty ? 'Full name is required' : null;

  String? validateEmail() =>
      emailController.text.trim().isEmpty ? 'Email is required' : null;

  String? validatePassport() => passportController.text.trim().isEmpty
      ? 'Passport number is required'
      : null;

  String? validateAddress() =>
      addressController.text.trim().isEmpty ? 'Address is required' : null;

  String? validatePhone() =>
      phoneController.text.trim().isEmpty ? 'Phone number is required' : null;

  String? validateDOB() =>
      selectedDate == null ? 'Date of birth is required' : null;

  String? validateNationality() =>
      selectedNationality == null || selectedNationality!.isEmpty
      ? 'Select nationality'
      : null;

  String? validateVisaType() =>
      selectedVisaType == null || selectedVisaType!.isEmpty
      ? 'Select visa type'
      : null;

  bool validateForm() {
    final validators = [
      validateFullName(),
      validateEmail(),
      validatePassport(),
      validateAddress(),
      validatePhone(),
      validateDOB(),
      validateNationality(),
      validateVisaType(),
    ];
    return !validators.any((e) => e != null);
  }

  Future<void> submitFormWithValidation(
    BuildContext context, {
    required String country,
    required String city,
    required String flag,
  }) async {
    if (!validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields and upload documents'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    await submitForm(context, country: country, city: city, flag: flag);
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

  String generateRandomId() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    String letterPart =
        letters[random.nextInt(letters.length)] +
        letters[random.nextInt(letters.length)];
    String numberPart = (10000000 + random.nextInt(90000000)).toString();
    return '$letterPart-$numberPart';
  }

  /// ✅ Updated submitForm to upload images and save URLs in Firestore
  Future<void> submitForm(
    BuildContext context, {
    required String country,
    required String city,
    required String flag,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      // ✅ Get URLs from ApplyProcessViewModel
      final applyVM = context.read<ApplyProcessViewModel>();

      final formData = {
        'visaFullName': fullNameController.text,
        'visaEmail': emailController.text,
        'visaNationality': selectedNationality,
        'visaPassportNumber': passportController.text,
        'visaType': selectedVisaType,
        'addressForVisa': addressController.text,
        'visaBirthDate': selectedDate?.toIso8601String(),
        'visaNumber': phoneController.text,
        'visaCountry': country,
        'visaCity': city,
        'createdAt': FieldValue.serverTimestamp(),
        'applicationId': generateRandomId(),
        'visaFlag': flag,
        'visaPhoneCode': selectedCountryCode,
        // 'photoUrl': photoUrl ?? '',
        // 'passportUrl': passportUrl ?? '',
        'photoUrl': applyVM.photoUrl ?? '', // ✅ Save uploaded photo URL
        'passportUrl':
            applyVM.passportUrl ?? '', // ✅ Save uploaded passport URL
      };

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
      debugPrint('Error submitting form: $e');
    }
  }

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

    notifyListeners();
  }
}

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
