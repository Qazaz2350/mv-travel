import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/commen/progress_indicator.dart';
import 'package:mvtravel/commen/skip_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/onboarding/nationality_residence_viewmodel.dart';
import 'package:mvtravel/views/onboarding/purpose_of_visit.dart';
import 'package:provider/provider.dart';

class NationalityResidenceScreen extends StatelessWidget {
  const NationalityResidenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NationalityResidenceViewModel(),
      child: Consumer<NationalityResidenceViewModel>(
        builder: (context, vm, _) {
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
                  StepIndicator(totalSteps: 9, currentStep: 3),
                  SizedBox(height: 32.h),

                  /// Title
                  Text(
                    'Nationality & Residence',
                    style: TextStyle(
                      fontSize: FontSizes.f20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  /// ---------------- NATIONALITY ----------------
                  Text(
                    'Nationality',
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      // border: Border.all(color: AppColors.grey2),
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select your nationality',
                          style: TextStyle(
                            fontSize: FontSizes.f14,
                            color: AppColors.grey2,
                          ),
                        ),
                        value: vm.selectedNationality,
                        icon: Icon(Icons.keyboard_arrow_down, size: 22.sp),
                        items: vm.countries
                            .map(
                              (country) => DropdownMenuItem(
                                value: country,
                                child: Text(
                                  country,
                                  style: TextStyle(fontSize: FontSizes.f14),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: vm.setNationality,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  /// ---------------- RESIDENCE ----------------
                  Text(
                    'Country of Residence',
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: AppColors.grey2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select your country of residence',
                          style: TextStyle(
                            fontSize: FontSizes.f14,
                            color: AppColors.grey2,
                          ),
                        ),
                        value: vm.selectedResidence,
                        icon: Icon(Icons.keyboard_arrow_down, size: 22.sp),
                        items: vm.countries
                            .map(
                              (country) => DropdownMenuItem(
                                value: country,
                                child: Text(
                                  country,
                                  style: TextStyle(fontSize: FontSizes.f14),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: vm.setResidence,
                      ),
                    ),
                  ),

                  Spacer(),

                  /// NEXT BUTTON
                  FRectangleButton(
                    text: 'Next',
                    color: AppColors.blue3,
                    onPressed: () {
                      Nav.push(context, VisitPurposeView());
                    },
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
