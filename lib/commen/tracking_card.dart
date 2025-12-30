import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/views/visa_application_screen/APPLICATION_SCREEN.dart';

import '../../model/visa_tracking_model.dart';

class VisaTrackingPage extends StatelessWidget {
  final VisaTrackingModel data;

  const VisaTrackingPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Nav.push(context, ApplicationStatusScreen(visaTracking: data));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            SizedBox(height: 16.h),
            _countrySection(),
            SizedBox(height: 20.h),
            _progressTracker(),
            SizedBox(height: 16.h),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data.visaType,
          style: TextStyle(
            color: AppColors.blue2,
            fontSize: FontSizes.f20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          data.status,
          style: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
        ),
      ],
    );
  }

  Widget _countrySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Country',
          style: TextStyle(
            color: AppColors.grey2,
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            SizedBox(
              width: 28.w,
              height: 28.w,
              child: Image.asset("assets/home/PK_flag.png"),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Pakistan to ${data.country}, ${data.visaCity}",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: FontSizes.f12,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 28.w,
              height: 28.w,
              child: Image.asset("assets/home/berlin_flag.png"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _footer() {
    return Container(
      padding: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.grey, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Applied Date: ${data.formattedCreatedAt}',
            style: TextStyle(fontSize: FontSizes.f12),
          ),
          Text(
            'pending',
            style: TextStyle(
              color: AppColors.grey2,
              fontSize: FontSizes.f12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressTracker() {
    final steps = [
      'Application\nSubmitted',
      'Documents\nVerified',
      'Payment\nConfirmation',
      'Decision',
    ];

    final isActive = data.country.isNotEmpty;

    return Column(
      children: [
        Row(
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              int stepIndex = index ~/ 2;
              bool done = stepIndex < data.currentStep;
              return Expanded(
                child: Container(
                  height: 2.h,
                  color: isActive && done ? AppColors.blue3 : AppColors.grey1,
                ),
              );
            }

            int stepIndex = index ~/ 2;
            bool done = stepIndex == 0
                ? isActive
                : stepIndex < data.currentStep;

            return Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: done ? AppColors.blue3 : AppColors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        SizedBox(height: 8.h),
        Row(
          children: steps
              .map(
                (e) => Expanded(
                  child: Text(
                    e,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: FontSizes.f10,
                      color: isActive ? AppColors.black : AppColors.grey2,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
