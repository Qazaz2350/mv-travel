import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/visa_tracking_model.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/views/visa_application_screen/APPLICATION_SCREEN.dart';
import 'package:mvtravel/view_model/visa_tracking_view_model.dart';
import 'package:provider/provider.dart';

class VisaTracking extends StatelessWidget {
  const VisaTracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<VisaTrackingViewModel>();

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Nav.pop(context),
        ),
        title: Text(
          'Active Application',
          style: TextStyle(
            color: AppColors.black,
            fontSize: FontSizes.f20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${vm.totalResults} Results',
              style: TextStyle(color: AppColors.grey2),
            ),
            SizedBox(height: 16.h),
            // Loop through applications
            for (var data in vm.applications)
              GestureDetector(
                onTap: () {
                  Nav.push(
                    context,
                    ApplicationStatusScreen(visaTracking: data),
                  );
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
                      // Header
                      Row(
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
                            style: TextStyle(
                              color: AppColors.grey2,
                              fontSize: FontSizes.f14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // Country Section
                      Column(
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
                                width: 24.w,
                                height: 24.w,
                                child: Image.asset(
                                  "assets/home/pakistan_flag.png",
                                ),
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
                              Container(
                                width: 24.w,
                                height: 24.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.r),
                                  color: AppColors.grey.withOpacity(0.2),
                                ),
                                child: Text(
                                  "${data.visaFlag}",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      // Progress Tracker
                      Column(
                        children: [
                          Row(
                            children: List.generate(7, (index) {
                              if (index.isOdd) {
                                int stepIndex = index ~/ 2;
                                bool done = stepIndex < data.currentStep;
                                return Expanded(
                                  child: Container(
                                    height: 2.h,
                                    color: data.country.isNotEmpty && done
                                        ? AppColors.blue3
                                        : AppColors.grey1,
                                  ),
                                );
                              }

                              int stepIndex = index ~/ 2;
                              bool done = stepIndex == 0
                                  ? data.country.isNotEmpty
                                  : stepIndex < data.currentStep;

                              return Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: BoxDecoration(
                                  color: done
                                      ? AppColors.blue3
                                      : AppColors.grey,
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              for (var step in [
                                'Application\nSubmitted',
                                'Documents\nVerified',
                                'Payment\nConfirmation',
                                'Decision',
                              ])
                                Expanded(
                                  child: Text(
                                    step,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: FontSizes.f10,
                                      color: data.country.isNotEmpty
                                          ? AppColors.black
                                          : AppColors.grey2,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // Footer
                      Container(
                        padding: EdgeInsets.only(top: 12.h),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: AppColors.grey, width: 1),
                          ),
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
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
