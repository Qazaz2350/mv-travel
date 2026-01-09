import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisaTrackingModel extends ChangeNotifier {
  final String type;
  final String status;
  final String country;
  final DateTime createdAt;
  final String feeStatus;
  final int currentStep;
  final String? visaFlag;

  final String? visaFullName;
  final String? visaEmail;
  final String? visaCity;
  final String? visaBirthDate;
  final String? visaNationality;
  final String? visaNumber;
  final String? visaPassportNumber;
  final String? addressForVisa;
  final String applicationId;
  final String visaType;
  final String processingTime;
  final String submissionId;
  final bool isPaid;

  final bool passportCompleted;
  final bool cnicCompleted;
  final bool photoCompleted;
  final bool travelVisaRequired;

  VisaTrackingModel({
    required this.visaFlag,
    required this.visaType,
    required this.processingTime,
    required this.submissionId,
    required this.isPaid,
    required this.passportCompleted,
    required this.cnicCompleted,
    required this.photoCompleted,
    required this.travelVisaRequired,
    required this.type,
    required this.status,
    required this.country,
    required this.createdAt,
    required this.feeStatus,
    required this.applicationId,
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
      visaFlag: json['visaFlag'] ?? null,
      visaType: json['visaType'] ?? 'Pending',
      processingTime: json['processingTime'] ?? 'Pending',
      submissionId: json['submissionId'] ?? 'Pending',
      isPaid: json['isPaid'] ?? false,
      passportCompleted: json['passportCompleted'] ?? false,
      cnicCompleted: json['cnicCompleted'] ?? false,
      photoCompleted: json['photoCompleted'] ?? false,
      travelVisaRequired: json['travelVisaRequired'] ?? false,
      type: json['type'] ?? 'Pending',
      country: json['visaCountry'] ?? 'Pending',
      status: json['status'] ?? 'Pending',
      feeStatus: json['feeStatus'] ?? 'Pending',
      currentStep: json['currentStep'] ?? 0,
      createdAt: timestamp?.toDate() ?? DateTime.now(),
      applicationId: json['applicationId'] ?? 'Pending',
      visaFullName: json['visaFullName'] ?? 'Pending',
      visaEmail: json['visaEmail'] ?? 'Pending',
      visaCity: json['visaCity'] ?? 'Pending',
      visaBirthDate: json['visaBirthDate'] ?? 'Pending',
      visaNationality: json['visaNationality'] ?? 'Pending',
      visaNumber: json['visaNumber'] ?? 'Pending',
      visaPassportNumber: json['visaPassportNumber'] ?? 'Pending',
      addressForVisa: json['addressForVisa'] ?? 'Pending',
    );
  }

  // ✅ Formatted applied date
  String get formattedCreatedAt {
    final formatter = DateFormat('dd-MM-yyyy h:mm a'); // 29-12-2025 6:00 AM
    return formatter.format(createdAt);
  }

  // ✅ Formatted visa birth date
  String get formattedVisaBirthDate {
    if (visaBirthDate == null || visaBirthDate == 'Pending') return 'Pending';

    try {
      // Parse the string to DateTime
      final date = DateTime.parse(visaBirthDate!);
      // Format as day-month-year without leading zeros
      return DateFormat('d-M-yyyy').format(date); // 27-2-2000
    } catch (e) {
      // Fallback if parsing fails
      return visaBirthDate!;
    }
  }
}
