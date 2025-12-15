import 'package:flutter/material.dart';
import 'package:mvtravel/model/onboarding/application_model.dart';

import 'package:mvtravel/utilis/colors.dart';

class ApplicationViewModel extends ChangeNotifier {
  final List<ApplicationModel> applications = [
    ApplicationModel(
      title: 'Work Visa',
      status: 'In Review',
      fromCountry: 'Pakistan',
      toCountry: 'Germany',
      fromFlag: 'assets/home/PK_flag.png',
      toFlag: 'assets/home/berlin_flag.png',
      appliedDate: '12 - Nov - 2025',
      feeStatus: 'Paid',
    ),
    ApplicationModel(
      title: 'Student Visa',
      status: 'Approved',
      fromCountry: 'Pakistan',
      toCountry: 'Canada',
      fromFlag: 'assets/home/PK_flag.png',
      toFlag: 'assets/home/berlin_flag.png',
      appliedDate: '05 - Oct - 2025',
      feeStatus: 'Paid',
    ),
    ApplicationModel(
      title: 'Tourist Visa',
      status: 'Pending',
      fromCountry: 'Pakistan',
      toCountry: 'UK',
      fromFlag: 'assets/home/PK_flag.png',
      toFlag: 'assets/home/berlin_flag.png',
      appliedDate: '20 - Dec - 2025',
      feeStatus: 'Unpaid',
    ),
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return AppColors.green1;
      case 'In Review':
        return AppColors.blue2;
      case 'Pending':
        return Colors.orange;
      default:
        return AppColors.grey2;
    }
  }
}
