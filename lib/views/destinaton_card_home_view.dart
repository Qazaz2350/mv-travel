import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/views/visa_application_screen/APPLICATION_SCREEN.dart';
import '../../model/visa_tracking_model.dart';

class VisaTrackingPageView extends StatelessWidget {
  final List<VisaTrackingModel> visaList;

  const VisaTrackingPageView({Key? key, required this.visaList})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        itemCount: visaList.length,
        padEnds: false,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: VisaTrackingCard(data: visaList[index]),
          );
        },
      ),
    );
  }
}

class VisaTrackingCard extends StatelessWidget {
  final VisaTrackingModel data;

  const VisaTrackingCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Nav.push(context, ApplicationStatusScreen(visaTracking: data));
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.white, AppColors.white.withOpacity(0.95)],
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.blue2.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColors.grey1.withOpacity(0.3), width: 1),
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.blue2.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            data.visaType,
            style: TextStyle(
              color: AppColors.blue2,
              fontSize: FontSizes.f16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.grey1,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            data.status,
            style: TextStyle(
              color: AppColors.grey2,
              fontSize: FontSizes.f12,
              fontWeight: FontWeight.w500,
            ),
          ),
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
            fontSize: FontSizes.f12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.blue2.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.grey1, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/home/PK_flag.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        size: 16.w,
                        color: AppColors.blue2,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          "${data.country}, ${data.visaCity}",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: FontSizes.f14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.grey1, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/home/berlin_flag.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _footer() {
    return Container(
      padding: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.grey1.withOpacity(0.5), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14.w, color: AppColors.grey2),
              SizedBox(width: 6.w),
              Text(
                data.formattedCreatedAt,
                style: TextStyle(
                  fontSize: FontSizes.f10,
                  color: AppColors.grey2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'pending',
              style: TextStyle(
                color: Colors.orange.shade700,
                fontSize: FontSizes.f10,
                fontWeight: FontWeight.w700,
              ),
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
