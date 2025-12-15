import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import '../../model/visa_tracking_model.dart';

class VisaTrackingCard extends StatelessWidget {
  final VisaTrackingModel data;

  const VisaTrackingCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
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
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data.type,
          style: TextStyle(
            color: AppColors.blue2,
            fontSize: FontSizes.f20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Container(
              width: 3.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: AppColors.grey2,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              data.status,
              style: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
            ),
          ],
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
                  data.country,
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
            'Applied Date: ${data.appliedDate}',
            style: TextStyle(fontSize: FontSizes.f12),
          ),
          Text(
            data.feeStatus,
            style: TextStyle(
              color: AppColors.green2,
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
      '     Decision',
    ];

    return Column(
      children: [
        Row(
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              bool done = index ~/ 2 < data.currentStep;
              return Expanded(
                child: Container(
                  height: 2.h,
                  color: done ? AppColors.blue3 : AppColors.grey1,
                ),
              );
            }
            bool done = index ~/ 2 < data.currentStep;
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
                    style: TextStyle(fontSize: FontSizes.f10),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
