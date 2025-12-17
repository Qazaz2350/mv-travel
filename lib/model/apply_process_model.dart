import 'dart:io';

class ApplyProcessModel {
  int currentStep;
  File? photoFile;
  File? passportFile;

  ApplyProcessModel({this.currentStep = 0, this.photoFile, this.passportFile});
}

class DetailModel {
  String fullName;
  String email;
  String? nationality;
  String passportNumber;
  String? visaType;
  String address;
  DateTime? dateOfBirth;
  String phoneNumber;
  String? passportDocumentPath;
  String? photoPath;

  DetailModel({
    required this.fullName,
    required this.email,
    this.nationality,
    required this.passportNumber,
    this.visaType,
    required this.address,
    this.dateOfBirth,
    required this.phoneNumber,
    this.passportDocumentPath,
    this.photoPath,
  });
}

class PaymentModel {
  final double totalAmount;
  final String applicationNumber;

  PaymentModel({required this.totalAmount, required this.applicationNumber});
}
