import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/onboarding/application_model.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/onboarding/application_view_model.dart';

class ApplicationCardWidget extends StatelessWidget {
  final ApplicationViewModel viewModel;

  const ApplicationCardWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225.h,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.96, // card spacing like ListView
        ),
        itemCount: viewModel.applications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: _buildCard(viewModel.applications[index]),
          );
        },
      ),
    );
  }

  Widget _buildCard(ApplicationModel app) {
    final statusColor = viewModel.getStatusColor(app.status);

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
          /// Header - Title and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  app.title,
                  style: TextStyle(
                    fontSize: FontSizes.f20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              _statusChip(app.status, statusColor),
            ],
          ),

          SizedBox(height: 12.h),

          /// Country Section
          _countrySection(app),
          SizedBox(height: 12.h),

          /// Steps Section
          _progressTracker(),

          const Spacer(),

          /// Footer
          _footer(app),
        ],
      ),
    );
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
            status,
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

  Widget _countrySection(ApplicationModel app) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(app.fromFlag, width: 20.w, height: 20.h),
            // SizedBox(width: 8.w),
            Text(
              '${app.fromCountry} to ${app.toCountry}',
              style: TextStyle(
                fontSize: FontSizes.f12,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            // SizedBox(width: 8.w),
            Image.asset(app.toFlag, width: 20.w, height: 20.h),
          ],
        ),
      ],
    );
  }

  Widget _buildStep(String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: isActive ? AppColors.blue2 : AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? AppColors.blue2 : AppColors.grey1,
              width: 2.w,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: 65.w,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FontSizes.f10,
              fontWeight: FontWeight.w400,
              color: isActive ? AppColors.black : AppColors.grey2,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _footer(ApplicationModel app) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Applied Date :${app.appliedDate}',
          style: TextStyle(
            fontSize: FontSizes.f10,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),

        // SizedBox(height: 4.h),
        Text(
          'Fee Status',
          style: TextStyle(
            fontSize: FontSizes.f10,
            color: AppColors.grey2,
            fontWeight: FontWeight.w400,
          ),
        ),

        // SizedBox(height: 4.h),
        // Text(
        //   app.feeStatus,
        //   style: TextStyle(
        //     fontSize: FontSizes.f12,
        //     fontWeight: FontWeight.w600,
        //     color: app.feeStatus == 'Paid' ? AppColors.green1 : AppColors.blue2,
        //   ),
        // ),
      ],
    );
  }
}

Widget _progressTracker() {
  final steps = [
    'Application\nSubmitted',
    'Documents\nVerified',
    'Payment\nConfirmation',
    '     Decision',
  ];

  // Static current step (e.g., step 2 is active)
  final int currentStep = 2;

  return Column(
    children: [
      Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            bool done = index ~/ 2 < currentStep;
            return Expanded(
              child: Container(
                height: 2.h,
                color: done ? AppColors.blue3 : AppColors.grey1,
              ),
            );
          }
          bool done = index ~/ 2 < currentStep;
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
