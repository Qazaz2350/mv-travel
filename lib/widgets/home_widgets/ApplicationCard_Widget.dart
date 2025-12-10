import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/model/home_page_model.dart';

class ApplicationCardWidget extends StatelessWidget {
  final VisaApplication application;

  const ApplicationCardWidget({Key? key, required this.application})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.grey1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                application.visaType,
                style: TextStyle(
                  fontSize: FontSizes.f20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blue1,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.green1.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: AppColors.green1,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      application.status.displayName,
                      style: TextStyle(
                        fontSize: FontSizes.f12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                'Country',
                style: TextStyle(
                  fontSize: FontSizes.f12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey2,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Image.asset(application.fromFlag, width: 24.w, height: 24.h),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  application.fromToCountry,
                  style: TextStyle(
                    fontSize: FontSizes.f14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
              Image.asset(application.toFlag, width: 24.w, height: 24.h),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: application.progress,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.blue1,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoColumn(
                'Application\nSubmitted',
                Icons.check_circle_outline,
              ),
              _buildInfoColumn('Documents\nVerified', Icons.verified_outlined),
              _buildInfoColumn('Payment\nConfirmation', Icons.payment),
              _buildInfoColumn('Decision\nReceived', Icons.mail_outline),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Applied Date:  ${application.formattedAppliedDate}',
                style: TextStyle(
                  fontSize: FontSizes.f12,
                  color: AppColors.grey2,
                ),
              ),
              Text(
                'Fee Status:  ${application.feeStatus}',
                style: TextStyle(
                  fontSize: FontSizes.f12,
                  color: AppColors.grey2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.blue1),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: FontSizes.f10, color: AppColors.grey2),
        ),
      ],
    );
  }
}
