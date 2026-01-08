import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/model/visa_tracking_model.dart';
import 'package:mvtravel/view_model/visa_tracking_view_model.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/Nav.dart';
import 'package:mvtravel/views/visa_tracking/visa_tracking.dart';
// import 'package:mvtravel/views/visa_application_screen/APPLICATION_SCREEN.dart';

class ActiveApplicationWidget extends StatelessWidget {
  const ActiveApplicationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final visaVM = context.watch<VisaTrackingViewModel>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          visaVM.applications.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Active Application',
                      style: TextStyle(
                        fontSize: FontSizes.f20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Nav.push(
                          context,
                          ChangeNotifierProvider(
                            create: (_) => VisaTrackingViewModel(),
                            child: const VisaTracking(),
                          ),
                        );
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontSize: FontSizes.f14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue1,
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),

          SizedBox(height: 16.h),

          if (visaVM.applications.isNotEmpty)
            GestureDetector(
              onTap: () {
                Nav.push(context, VisaTracking());
              },
              child: SizedBox(
                height: 260.h, // widget hamesha reserved
                child: visaVM.applications.isEmpty
                    ? const Center(
                        child: Text('No active applications'),
                      ) // ya loader
                    : PageView.builder(
                        controller: PageController(
                          viewportFraction: 0.99,
                        ), // directly use
                        padEnds: false,
                        itemCount: visaVM.applications.length,
                        itemBuilder: (context, index) {
                          final data = visaVM.applications[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.white,
                                    AppColors.white.withOpacity(0.95),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.blue2.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(
                                  color: AppColors.grey1.withOpacity(0.3),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.blue2.withOpacity(
                                            0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Text(
                                          data.visaType,
                                          style: TextStyle(
                                            fontSize: FontSizes.f16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.blue2,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.grey1,
                                          borderRadius: BorderRadius.circular(
                                            6.r,
                                          ),
                                        ),
                                        child: Text(
                                          data.status,
                                          style: TextStyle(
                                            fontSize: FontSizes.f12,
                                            color: AppColors.grey2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 16.h),

                                  Text(
                                    'Country',
                                    style: TextStyle(
                                      fontSize: FontSizes.f12,
                                      color: AppColors.grey2,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 10.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.blue2.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${data.country}, ${data.visaCity},",
                                        style: TextStyle(
                                          fontSize: FontSizes.f14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 20.h),

                                  _progressTracker(data),

                                  SizedBox(height: 16.h),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data.formattedCreatedAt,
                                        style: TextStyle(
                                          fontSize: FontSizes.f10,
                                          color: AppColors.grey2,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            6.r,
                                          ),
                                        ),
                                        child: Text(
                                          'pending',
                                          style: TextStyle(
                                            fontSize: FontSizes.f10,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.orange.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _progressTracker(VisaTrackingModel data) {
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
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: isActive && done ? AppColors.blue3 : AppColors.grey1,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              );
            }

            int stepIndex = index ~/ 2;
            bool done = stepIndex == 0
                ? isActive
                : stepIndex < data.currentStep;

            return Container(
              width: 16.w,
              height: 16.w,
              decoration: BoxDecoration(
                color: done ? AppColors.blue3 : AppColors.grey1,
                shape: BoxShape.circle,
                boxShadow: done
                    ? [
                        BoxShadow(
                          color: AppColors.blue3.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: done
                  ? Icon(Icons.check, size: 10.w, color: AppColors.white)
                  : null,
            );
          }),
        ),
        SizedBox(height: 10.h),
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
                      fontWeight: FontWeight.w500,
                      height: 1.3,
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
