// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/purpose_of_visit_model.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/commen/full_size_button.dart';
import 'package:mvtravel/utilis/commen/progress_indicator.dart';
import 'package:mvtravel/utilis/commen/widgets/skip_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/Purpose_of_visit_ViewModel.dart';
import 'package:mvtravel/views/user_verification/purpose/international_students_view.dart';
import 'package:mvtravel/views/user_verification/purpose/travel_visit_screen.dart';
import 'package:provider/provider.dart';

class VisitPurposeView extends StatelessWidget {
  const VisitPurposeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VisitPurposeViewModel(),
      child: const _VisitPurposeContent(),
    );
  }
}

class _VisitPurposeContent extends StatelessWidget {
  const _VisitPurposeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<VisitPurposeViewModel>();
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 22.sp),
          onPressed: () => Nav.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: SkipButton(onPressed: () {}),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepIndicator(totalSteps: 9, currentStep: 4),
            SizedBox(height: 32.h),

            // return Scaffold(
            //   backgroundColor: AppColors.white,
            //   appBar: AppBar(
            //     backgroundColor: AppColors.white,
            //     elevation: 0,
            //     leading: IconButton(
            //       icon: Icon(Icons.arrow_back, color: AppColors.black),
            //       onPressed: () => Nav.pop(context),
            //     ),
            //     actions: [
            //       TextButton(
            //         onPressed: () {
            //           // Navigate to next screen
            //         },
            //         child: Text(
            //           'Skip',
            //           style: TextStyle(
            //             color: AppColors.blue1,
            //             fontSize: FontSizes.f16,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //   body: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 24.w),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         StepIndicator(totalSteps: 9, currentStep: 4),
            //         SizedBox(height: 32.h),
            Text(
              'What is the main\npurpose of your visit?',
              style: TextStyle(
                fontSize: FontSizes.f20,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                height: 1.2,
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio: 0.8,
                ),
                itemCount: viewModel.purposes.length,
                itemBuilder: (context, index) {
                  final purpose = viewModel.purposes[index];
                  return _PurposeCard(
                    purpose: purpose,
                    isSelected: viewModel.isPurposeSelected(purpose.id),
                    onTap: () {
                      viewModel.selectPurpose(purpose.id);

                      if (purpose.id == 'travel') {
                        Nav.push(context, const TravelVisaView());
                      } else if (purpose.id == 'student') {
                        Nav.push(context, const InternationalStudentsView());
                      } else if (purpose.id == 'work') {
                        Nav.push(context, const TravelVisaView());
                      } else if (purpose.id == 'investment') {
                        Nav.push(context, const TravelVisaView());
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            FRectangleButton(
              text: 'Next',
              color: AppColors.blue3,
              onPressed: () => Nav.pop(context),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class _PurposeCard extends StatelessWidget {
  final VisitPurpose purpose;
  final bool isSelected;
  final VoidCallback onTap;

  const _PurposeCard({
    Key? key,
    required this.purpose,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColors.blue1 : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                // color: AppColors.blue1.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Image.asset(
                  purpose.imagePath,
                  width: 28.w,
                  height: 28.w,
                  color: AppColors.blue1,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback icon if image not found
                    return Icon(
                      Icons.image,
                      size: 28.sp,
                      color: AppColors.blue1,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              purpose.title,
              style: TextStyle(
                fontSize: FontSizes.f16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                height: 1.3,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              purpose.description,
              style: TextStyle(
                fontSize: FontSizes.f12,
                color: AppColors.grey2,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
