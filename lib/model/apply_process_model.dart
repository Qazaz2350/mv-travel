import 'dart:io';

class ApplyProcessModel {
  int currentStep;
  File? photoFile;
  File? passportFile;

  /// ✅ Fields to store uploaded file URLs
  String? photoUrl;
  String? passportUrl;

  ApplyProcessModel({
    this.currentStep = 0,
    this.photoFile,
    this.passportFile,
    this.photoUrl,
    this.passportUrl,
  });
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

  DetailModel({
    required this.fullName,
    required this.email,
    this.nationality,
    required this.passportNumber,
    this.visaType,
    required this.address,
    this.dateOfBirth,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'nationality': nationality,
      'passportNumber': passportNumber,
      'visaType': visaType,
      'address': address,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'phoneNumber': phoneNumber,
    };
  }

  factory DetailModel.fromMap(Map<String, dynamic> map) {
    return DetailModel(
      fullName: map['fullName'],
      email: map['email'],
      nationality: map['nationality'],
      passportNumber: map['passportNumber'],
      visaType: map['visaType'],
      address: map['address'],
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map['dateOfBirth'])
          : null,
      phoneNumber: map['phoneNumber'],
    );
  }
}

class PaymentModel {
  final double totalAmount;
  final String applicationNumber;

  PaymentModel({required this.totalAmount, required this.applicationNumber});
}
