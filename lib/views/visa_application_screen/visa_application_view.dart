import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/half_button.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';

class ApplicationsStatusScreen extends StatelessWidget {
  const ApplicationsStatusScreen({Key? key}) : super(key: key);

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
          'Applications Status',
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
            // Header Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                left: 16.w,
                top: 16.h,
                bottom: 20.h,
                right: 178.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pakistan - Germany',
                    style: TextStyle(
                      fontSize: FontSizes.f20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Travel Visa',
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      color: AppColors.grey2,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 22.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildProgressStep('Application\nSubmitted', true),
                        _buildProgressLine(true),
                        _buildProgressStep('Documents\nVerified', true),
                        _buildProgressLine(true),
                        _buildProgressStep('Payment\nconfirmation', true),
                        _buildProgressLine(true),
                        _buildProgressStep('Decision', true),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Documents Uploaded Section
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Documents Uploaded',
                          style: TextStyle(
                            fontSize: FontSizes.f16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildDocumentItem('Passport.pdf'),
                        SizedBox(height: 12.h),
                        _buildDocumentItem('CNIC.jpg'),
                        SizedBox(height: 12.h),
                        _buildDocumentItem('Photo.jpg'),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Application Details Section
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Application Details',
                          style: TextStyle(
                            fontSize: FontSizes.f16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailRow('Visa Type', 'Travel Visa'),
                        SizedBox(height: 12.h),
                        _buildDetailRow('Processing Time', '15 - 20 Days'),
                        SizedBox(height: 12.h),
                        _buildDetailRow('Submission ID', 'TRV-453829'),
                        SizedBox(height: 12.h),
                        _buildDetailRow('Payment Status', 'Paid', isPaid: true),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Need Help Section
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need Help?',
                          style: TextStyle(
                            fontSize: FontSizes.f16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: ActionButton(
                                text: 'Call Now',
                                bgColor: AppColors.blue2,
                                textColor: AppColors.white,
                                onTap: () {
                                  // Handle call action
                                },
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: ActionButton(
                                text: 'Chat Now',
                                bgColor: AppColors.green1,
                                textColor: AppColors.white,
                                onTap: () {
                                  // Handle chat action
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Progress Steps
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(String label, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.blue2 : AppColors.grey1,
            shape: BoxShape.circle,
          ),
          child: isCompleted
              ? Icon(Icons.check, color: Colors.white, size: 14.sp)
              : null,
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 60.w,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FontSizes.f10,
              color: AppColors.black,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(bool isCompleted) {
    return Container(
      width: 20.w,
      height: 2.h,
      color: isCompleted ? AppColors.blue2 : AppColors.grey1,
      margin: EdgeInsets.only(bottom: 30.h),
    );
  }

  Widget _buildDocumentItem(String fileName) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Icons.description_outlined, color: AppColors.grey2, size: 32.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: TextStyle(
                    fontSize: FontSizes.f14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: FontSizes.f12,
                    color: AppColors.green1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: AppColors.green1,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white, size: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isPaid = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: FontSizes.f14, color: AppColors.grey2),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w600,
            color: isPaid ? AppColors.green1 : AppColors.black,
          ),
        ),
      ],
    );
  }
}
