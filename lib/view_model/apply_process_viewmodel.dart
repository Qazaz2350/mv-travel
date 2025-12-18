import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvtravel/model/apply_process_model.dart';
import 'package:mvtravel/utilis/colors.dart';

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
  String? passportDocumentName;
  String? photoDocumentName;

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

  // Select date
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
          ).copyWith(colorScheme: ColorScheme.light(primary: AppColors.blue)),
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
          passportDocumentName = image.name;
        } else {
          photoDocument = File(image.path);
          photoDocumentName = image.name;
        }
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error picking image: $e');
    }
  }

  bool validateForm(BuildContext context) {
    if (fullNameController.text.isEmpty) {
      _showError(context, 'Please enter your full name');
      return false;
    }
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      _showError(context, 'Please enter a valid email address');
      return false;
    }
    if (selectedNationality == null) {
      _showError(context, 'Please select your nationality');
      return false;
    }
    if (passportController.text.isEmpty) {
      _showError(context, 'Please enter your passport number');
      return false;
    }
    if (selectedVisaType == null) {
      _showError(context, 'Please select a visa type');
      return false;
    }
    if (addressController.text.isEmpty) {
      _showError(context, 'Please enter your address');
      return false;
    }
    if (selectedDate == null) {
      _showError(context, 'Please select your date of birth');
      return false;
    }
    if (phoneController.text.isEmpty) {
      _showError(context, 'Please enter your phone number');
      return false;
    }
    if (passportDocument == null) {
      _showError(context, 'Please upload your passport document');
      return false;
    }
    if (photoDocument == null) {
      _showError(context, 'Please upload your photo');
      return false;
    }
    return true;
  }

  void submitForm(BuildContext context) {
    if (validateForm(context)) {
      final formData = DetailModel(
        fullName: fullNameController.text,
        email: emailController.text,
        nationality: selectedNationality,
        passportNumber: passportController.text,
        visaType: selectedVisaType,
        address: addressController.text,
        dateOfBirth: selectedDate,
        phoneNumber: '$selectedCountryCode ${phoneController.text}',
        passportDocumentPath: passportDocument?.path,
        photoPath: photoDocument?.path,
      );

      print('Form Data: ${formData.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}

//payment
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
