import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/visa_tracking_model.dart';
import 'package:mvtravel/utilis/nav.dart';
// import 'package:mvtravel/view_model/visa_tracking_view_model.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/views/visa_application_screen/APPLICATION_SCREEN.dart';
// import '../model/visa_tracking_model.dart';

class ApplicationCardWidget extends StatelessWidget {
  final List<VisaTrackingModel> applicationList; // ✅ FIX

  const ApplicationCardWidget({super.key, required this.applicationList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: ValueKey(DateTime.now().millisecondsSinceEpoch),
      height: 225.h,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.96),
        itemCount: applicationList.length,
        itemBuilder: (context, index) {
          final app = applicationList[index];
          return Padding(
            // ────────────────────────────────────────────────
            //           This is the KEY line you need
            key: ValueKey(app.applicationId), // ← Perfect!
            // ────────────────────────────────────────────────
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: _buildCard(app, context),
          );
        },
      ),
    );
  }

  Widget _buildCard(VisaTrackingModel app, BuildContext context) {
    return Container(
      height: 320.h,
      width: 320.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  app.visaType,
                  style: TextStyle(
                    fontSize: FontSizes.f20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              _statusChip(app.status, AppColors.green1),
            ],
          ),
          SizedBox(height: 12.h),
          _countrySection(app),
          SizedBox(height: 12.h),
          _progressTracker(app.currentStep, country: app.country),
          const Spacer(),
          _footer(app),
        ],
      ),
    );
  }
}

Widget _statusChip(String status, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6.w,
          height: 6.h,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text(
          status, // ✅ Show actual status
          style: TextStyle(
            fontSize: FontSizes.f12,
            fontWeight: FontWeight.w500,
            color: AppColors.blue3,
          ),
        ),
      ],
    ),
  );
}

Widget _countrySection(VisaTrackingModel app) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Country',
        style: TextStyle(
          fontSize: FontSizes.f14,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 8.h),
      Text(
        app.country, // ✅ Use VisaTrackingModel's country
        style: TextStyle(
          fontSize: FontSizes.f12,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
    ],
  );
}

Widget _footer(VisaTrackingModel app) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Applied Date : ${app.formattedCreatedAt}', // ✅ Use formatted date
        style: TextStyle(
          fontSize: FontSizes.f10,
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      Text(
        'Fee Status: ${app.feeStatus}',
        style: TextStyle(
          fontSize: FontSizes.f10,
          color: AppColors.grey2,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

// Updated _progressTracker to accept dynamic step
Widget _progressTracker(int currentStep, {required String country}) {
  final steps = [
    'Application\nSubmitted',
    'Documents\nVerified',
    'Payment\nConfirmation',
    'Decision',
  ];

  final isFirstStepActive = country.isNotEmpty;

  return Column(
    children: [
      Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            // Line between circles
            int stepIndex = index ~/ 2;
            bool done = stepIndex == 0
                ? isFirstStepActive
                : stepIndex < currentStep;
            return Expanded(
              child: Container(
                height: 2.h,
                color: done ? AppColors.blue3 : AppColors.grey1,
              ),
            );
          }

          int stepIndex = index ~/ 2;
          bool done = stepIndex == 0
              ? isFirstStepActive
              : stepIndex < currentStep;

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
                    color: currentStep > 0 || isFirstStepActive
                        ? AppColors.black
                        : AppColors.grey2,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ],
  );
}
