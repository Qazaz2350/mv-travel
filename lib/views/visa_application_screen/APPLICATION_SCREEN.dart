import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/visa_tracking_model.dart';
import 'package:mvtravel/commen/half_button.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';

class ApplicationStatusScreen extends StatelessWidget {
  final VisaTrackingModel visaTracking;

  const ApplicationStatusScreen({Key? key, required this.visaTracking})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Nav.pop(context),
        ),
        title: Text(
          'Application Status',
          style: TextStyle(
            color: AppColors.black,
            fontSize: FontSizes.f20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Status Badge
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade50],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.blue2,
                              AppColors.blue2.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blue2.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.flight_takeoff,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pakistan → ${visaTracking.country}',
                              style: TextStyle(
                                fontSize: FontSizes.f20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              visaTracking.type,
                              style: TextStyle(
                                fontSize: FontSizes.f14,
                                color: AppColors.grey2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Status Badge
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _getStatusGradient(visaTracking.status),
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: _getStatusColor(
                            visaTracking.status,
                          ).withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getStatusIcon(visaTracking.status),
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Status: ${visaTracking.status}',
                          style: TextStyle(
                            fontSize: FontSizes.f16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Progress Tracker
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.track_changes,
                              color: AppColors.blue2,
                              size: 24.sp,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Application Progress',
                              style: TextStyle(
                                fontSize: FontSizes.f16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildProgressStep(
                              'Application\nSubmitted',
                              visaTracking.currentStep >= 1,
                              1,
                            ),
                            _buildProgressLine(visaTracking.currentStep >= 2),
                            _buildProgressStep(
                              'Documents\nVerified',
                              visaTracking.currentStep >= 2,
                              2,
                            ),
                            _buildProgressLine(visaTracking.currentStep >= 3),
                            _buildProgressStep(
                              'Payment\nConfirmed',
                              visaTracking.currentStep >= 3,
                              3,
                            ),
                            _buildProgressLine(visaTracking.currentStep >= 4),
                            _buildProgressStep(
                              'Decision\nMade',
                              visaTracking.currentStep >= 4,
                              4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Applicant Personal Information
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.blue2.withOpacity(0.2),
                                    AppColors.blue2.withOpacity(0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.person_outline,
                                color: AppColors.blue2,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: FontSizes.f16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        if (visaTracking.visaFullName != null)
                          _buildInfoRow(
                            Icons.person,
                            'Full Name',
                            visaTracking.visaFullName!,
                          ),
                        if (visaTracking.visaEmail != null) ...[
                          SizedBox(height: 16.h),
                          _buildInfoRow(
                            Icons.email_outlined,
                            'Email Address',
                            visaTracking.visaEmail!,
                          ),
                        ],
                        if (visaTracking.visaNationality != null) ...[
                          SizedBox(height: 16.h),
                          _buildInfoRow(
                            Icons.flag_outlined,
                            'Nationality',
                            visaTracking.visaNationality!,
                          ),
                        ],
                        if (visaTracking.visaBirthDate != null &&
                            visaTracking.visaBirthDate != 'Pending') ...[
                          SizedBox(height: 16.h),
                          _buildInfoRow(
                            Icons.cake_outlined,
                            'Date of Birth',
                            visaTracking
                                .formattedVisaBirthDate, // ✅ use the formatted getter
                          ),
                        ],

                        if (visaTracking.visaCity != null) ...[
                          SizedBox(height: 16.h),
                          _buildInfoRow(
                            Icons.location_city_outlined,
                            'City',
                            visaTracking.visaCity!,
                          ),
                        ],
                        if (visaTracking.addressForVisa != null) ...[
                          SizedBox(height: 16.h),
                          _buildInfoRow(
                            Icons.home_outlined,
                            'Address',
                            visaTracking.addressForVisa!,
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Travel Documents
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.blue2.withOpacity(0.2),
                                    AppColors.blue2.withOpacity(0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.card_travel,
                                color: AppColors.blue2,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Travel Documents',
                              style: TextStyle(
                                fontSize: FontSizes.f16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        if (visaTracking.visaPassportNumber != null)
                          _buildDocumentCard(
                            Icons.chrome_reader_mode,
                            'Passport Number',
                            visaTracking.visaPassportNumber!,
                            AppColors.blue2,
                          ),
                        if (visaTracking.visaNumber != null) ...[
                          SizedBox(height: 12.h),
                          _buildDocumentCard(
                            Icons.qr_code,
                            'Visa Number',
                            visaTracking.visaNumber!,
                            AppColors.green1,
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Application Details
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.blue2.withOpacity(0.2),
                                    AppColors.blue2.withOpacity(0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.info_outline,
                                color: AppColors.blue2,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Application Details',
                              style: TextStyle(
                                fontSize: FontSizes.f16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        _buildDetailRow(
                          'Application ID',
                          visaTracking.applicationId,
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailRow('Visa Type', visaTracking.visaType),
                        SizedBox(height: 16.h),
                        _buildDetailRow('Destination', visaTracking.country),
                        SizedBox(height: 16.h),
                        _buildDetailRow(
                          'Applied On',
                          visaTracking.formattedCreatedAt,
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailRow(
                          'Payment Status',
                          visaTracking.feeStatus,
                          isPaid:
                              visaTracking.feeStatus.toLowerCase() == 'paid',
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailRow(
                          'Current Status',
                          visaTracking.status,
                          statusColor: _getStatusColor(visaTracking.status),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Need Help
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.blue.shade50.withOpacity(0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.blue2.withOpacity(0.2),
                                    AppColors.blue2.withOpacity(0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.support_agent,
                                color: AppColors.blue2,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Need Assistance?',
                              style: TextStyle(
                                fontSize: FontSizes.f16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Our support team is available 24/7 to help you with your application',
                          style: TextStyle(
                            fontSize: FontSizes.f14,
                            color: AppColors.grey2,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: ActionButton(
                                text: 'Call Now',
                                bgColor: AppColors.blue2,
                                textColor: AppColors.white,
                                onTap: () {},
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: ActionButton(
                                text: 'Chat Now',
                                bgColor: AppColors.green1,
                                textColor: AppColors.white,
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
      case 'completed':
        return AppColors.green1;
      case 'pending':
      case 'in progress':
        return Colors.orange;
      case 'rejected':
      case 'cancelled':
        return Colors.red;
      default:
        return AppColors.blue2;
    }
  }

  List<Color> _getStatusGradient(String status) {
    final baseColor = _getStatusColor(status);
    return [baseColor, baseColor.withOpacity(0.8)];
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
      case 'completed':
        return Icons.check_circle;
      case 'pending':
      case 'in progress':
        return Icons.pending;
      case 'rejected':
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  Widget _buildProgressStep(String label, bool isCompleted, int stepNumber) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            gradient: isCompleted
                ? LinearGradient(
                    colors: [AppColors.blue2, AppColors.blue2.withOpacity(0.8)],
                  )
                : null,
            color: isCompleted ? null : AppColors.grey1,
            shape: BoxShape.circle,
            boxShadow: isCompleted
                ? [
                    BoxShadow(
                      color: AppColors.blue2.withOpacity(0.4),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 18.sp)
                : Text(
                    '$stepNumber',
                    style: TextStyle(
                      color: AppColors.grey2,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSizes.f12,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 60.w,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FontSizes.f10,
              color: isCompleted ? AppColors.black : AppColors.grey2,
              height: 1.2,
              fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(bool isCompleted) {
    return Container(
      width: 20.w,
      height: 3.h,
      decoration: BoxDecoration(
        gradient: isCompleted
            ? LinearGradient(
                colors: [AppColors.blue2, AppColors.blue2.withOpacity(0.8)],
              )
            : null,
        color: isCompleted ? null : AppColors.grey1,
        borderRadius: BorderRadius.circular(2.r),
      ),
      margin: EdgeInsets.only(bottom: 30.h),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey1.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.blue2.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: AppColors.blue2, size: 20.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: FontSizes.f12,
                    color: AppColors.grey2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: FontSizes.f14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: FontSizes.f12,
                    color: AppColors.grey2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: FontSizes.f14,
                    fontWeight: FontWeight.w700,
                    color: color,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(Icons.verified, color: Colors.white, size: 18.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isPaid = false,
    Color? statusColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: FontSizes.f14,
            color: AppColors.grey2,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            gradient: isPaid || statusColor != null
                ? LinearGradient(
                    colors: [
                      (statusColor ?? AppColors.green1).withOpacity(0.2),
                      (statusColor ?? AppColors.green1).withOpacity(0.1),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(8.r),
            border: isPaid || statusColor != null
                ? Border.all(
                    color: (statusColor ?? AppColors.green1).withOpacity(0.3),
                    width: 1.5,
                  )
                : null,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: FontSizes.f14,
              fontWeight: FontWeight.w700,
              color: isPaid || statusColor != null
                  ? (statusColor ?? AppColors.green1)
                  : AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
