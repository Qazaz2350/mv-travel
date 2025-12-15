import 'package:flutter/material.dart';
import '../model/visa_tracking_model.dart';

class VisaTrackingViewModel extends ChangeNotifier {
  final List<VisaTrackingModel> applications = [
    VisaTrackingModel(
      type: 'Travel Visa',
      status: 'In Review',
      country: 'Pakistan to Germany',
      appliedDate: '12 - Nov - 2025',
      feeStatus: 'Paid',
      currentStep: 2,
    ),
    VisaTrackingModel(
      type: 'Student Visa',
      status: 'In Review',
      country: 'Pakistan to Germany',
      appliedDate: '12 - Nov - 2025',
      feeStatus: 'Paid',
      currentStep: 2,
    ),
    VisaTrackingModel(
      type: 'Work Visa',
      status: 'In Review',
      country: 'Pakistan to Germany',
      appliedDate: '12 - Nov - 2025',
      feeStatus: 'Paid',
      currentStep: 2,
    ),
  ];

  int get totalResults => applications.length;
}
