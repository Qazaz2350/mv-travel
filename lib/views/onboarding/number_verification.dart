import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/commen/progress_indicator.dart';
import 'package:mvtravel/commen/skip_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/onboarding/phone_number_viewmodel.dart';
import 'package:mvtravel/views/home/home_dashboard.dart';
import 'package:mvtravel/views/onboarding/select_birthdate.dart';
import 'package:mvtravel/widgets/message.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhoneNumberViewModel(),
      child: Consumer<PhoneNumberViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: AppColors.grey,
            appBar: AppBar(
              backgroundColor: AppColors.grey,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Nav.pop(context),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: SkipButton(
                    onPressed: () {
                      Nav.push(context, BirthDateScreen());
                    },
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepIndicator(totalSteps: 9, currentStep: 1),
                  const SizedBox(height: 32),
                  Text(
                    'What is your phone number?',
                    style: TextStyle(
                      fontSize: FontSizes.f20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We need your phone number to provide status updates on your visa',
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),

                  /// 🔽 COUNTRY CODE + PHONE FIELD
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 110,
                        height: 48.5,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.blue2,
                              width: 2,
                            ),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            value: vm.selectedCountryCode,

                            /// ✅ DROPDOWN OPENS BELOW
                            dropdownStyleData: DropdownStyleData(
                              direction: DropdownDirection.left,
                              width: 120,
                              maxHeight: 500,
                              offset: const Offset(0, 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),

                            buttonStyleData: ButtonStyleData(
                              height: 49,
                              width: 110,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                            ),

                            items: vm.countryCodes.map((country) {
                              return DropdownMenuItem<String>(
                                value: country['code'],
                                child: Row(
                                  children: [
                                    Text(
                                      country['flag']!,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      country['code']!,
                                      style: TextStyle(fontSize: FontSizes.f16),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),

                            onChanged: (value) {
                              vm.changeCountry(value!);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      /// 📱 PHONE NUMBER FIELD
                      /// SIZE
                      Expanded(
                        child: TextField(
                          controller: vm.phoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: FontSizes.f16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'xxxxxxxxxx',
                            hintStyle: TextStyle(color: AppColors.grey2),
                            border: const UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[500]!),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.blue2,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// ▶ NEXT BUTTON
                  FRectangleButton(
                    text: 'Next',
                    color: AppColors.blue3,
                    onPressed: () async {
                      try {
                        await vm.savePhoneNumber();
                        // Success message optional
                        // showCustomSnackBar(context, 'Phone number saved successfully!');
                        Nav.push(context, BirthDateScreen());
                      } catch (e) {
                        showCustomSnackBar(
                          context,
                          e.toString(),
                          isError: true,
                        );
                      }
                    },
                  ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
