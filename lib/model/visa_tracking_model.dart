import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VisaTrackingModel {
  final String type;
  final String status;
  final String country;
  final DateTime createdAt;
  final String feeStatus;
  final int currentStep;

  final String? visaFullName;
  final String? visaEmail;
  final String? visaCity;
  final String? visaBirthDate;
  final String? visaNationality;
  final String? visaNumber;
  final String? visaPassportNumber;
  final String? addressForVisa;

  VisaTrackingModel({
    required this.type,
    required this.status,
    required this.country,
    required this.createdAt,
    required this.feeStatus,
    required this.currentStep,
    this.visaFullName,
    this.visaEmail,
    this.visaCity,
    this.visaBirthDate,
    this.visaNationality,
    this.visaNumber,
    this.visaPassportNumber,
    this.addressForVisa,
  });

  factory VisaTrackingModel.fromFirestore(Map<String, dynamic> json) {
    final timestamp = json['createdAt'] as Timestamp?;

    return VisaTrackingModel(
      type: json['visaType'] ?? '',
      country: json['visaCountry'] ?? '',
      status: json['status'] ?? 'In Progress',
      feeStatus: json['feeStatus'] ?? 'Paid',
      currentStep: json['currentStep'] ?? 0,
      createdAt: timestamp?.toDate() ?? DateTime.now(),

      visaFullName: json['visaFullName'],
      visaEmail: json['visaEmail'],
      visaCity: json['visaCity'],
      visaBirthDate: json['visaBirthDate'],
      visaNationality: json['visaNationality'],
      visaNumber: json['visaNumber'],
      visaPassportNumber: json['visaPassportNumber'],
      addressForVisa: json['addressForVisa'],
    );
  }

  // ✅ Formatted applied date
  String get formattedCreatedAt {
    final formatter = DateFormat('dd-MM-yyyy h:mm a'); // 29-12-2025 6:00 AM
    return formatter.format(createdAt);
  }
}
