import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mvtravel/commen/country_list.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/commen/progress_indicator.dart';
import 'package:mvtravel/commen/skip_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/onboarding/nationality_residence_viewmodel.dart';
import 'package:mvtravel/views/onboarding/purpose_of_visit.dart';
import 'package:mvtravel/widgets/message.dart';
import 'package:provider/provider.dart';
import 'package:country_flags/country_flags.dart';

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
                  child: SkipButton(
                    onPressed: () {
                      Nav.push(context, VisitPurposeView());
                    },
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepIndicator(totalSteps: 9, currentStep: 3),
                  SizedBox(height: 32.h),

                  /// TITLE
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
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<Country>(
                        isExpanded: true,
                        value: vm.selectedNationality,
                        hint: Text(
                          'Select your nationality',
                          style: TextStyle(
                            fontSize: FontSizes.f14,
                            color: AppColors.grey2,
                          ),
                        ),
                        iconStyleData: IconStyleData(
                          icon: Icon(Icons.keyboard_arrow_down, size: 22.sp),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 440,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          offset: const Offset(0, 4),
                        ),
                        items: vm.countries.map((country) {
                          return DropdownMenuItem<Country>(
                            value: country,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.w),
                                  child: CountryFlag.fromCountryCode(
                                    country.code
                                        .toLowerCase(), // make sure code is lowercase
                                    theme: const ImageTheme(
                                      width: 22,
                                      height: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  country.name,
                                  style: TextStyle(
                                    fontSize: FontSizes.f14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
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
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<Country>(
                        isExpanded: true,
                        value: vm.selectedResidence,
                        hint: Text(
                          'Select your country of residence',
                          style: TextStyle(
                            fontSize: FontSizes.f14,
                            color: AppColors.grey2,
                          ),
                        ),
                        iconStyleData: IconStyleData(
                          icon: Icon(Icons.keyboard_arrow_down, size: 22.sp),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          offset: const Offset(0, 4),
                        ),
                        items: vm.countries.map((country) {
                          return DropdownMenuItem<Country>(
                            value: country,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.w),
                                  child: CountryFlag.fromCountryCode(
                                    country.code
                                        .toLowerCase(), // ✅ must be lowercase ISO code
                                    theme: const ImageTheme(
                                      width: 22,
                                      height: 14,
                                    ), // set size
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  country.name,
                                  style: TextStyle(
                                    fontSize: FontSizes.f14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: vm.setResidence,
                      ),
                    ),
                  ),

                  const Spacer(),

                  /// NEXT BUTTON
                  FRectangleButton(
                    text: 'Next',
                    color: AppColors.blue3,
                    onPressed: () async {
                      final vm = context.read<NationalityResidenceViewModel>();

                      // ✅ Validation
                      if (!vm.isNationalityValid) {
                        showCustomSnackBar(
                          context,
                          'Please select your nationality',
                          isError: true,
                        );
                        return;
                      }

                      if (!vm.isResidenceValid) {
                        showCustomSnackBar(
                          context,
                          'Please select your residence',
                          isError: true,
                        );
                        return;
                      }

                      // Save to Firebase
                      await vm.saveToFirebase();

                      // Navigate to next screen
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
