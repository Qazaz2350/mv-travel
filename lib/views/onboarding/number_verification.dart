import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/commen/progress_indicator.dart';
import 'package:mvtravel/commen/skip_button.dart';
import 'package:mvtravel/utilis/nav.dart';
// import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/view_model/onboarding/phone_number_viewmodel.dart';
import 'package:mvtravel/views/home/home_dashboard.dart';
import 'package:mvtravel/views/onboarding/select_birthdate.dart';
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
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Nav.pop(context),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: SkipButton(
                    onPressed: () {
                      Nav.push(context, HomePageView());
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
                  StepIndicator(totalSteps: 9, currentStep: 1),
                  SizedBox(height: 32),
                  Text(
                    'What is your phone number?',
                    style: TextStyle(
                      fontSize: FontSizes.f20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We need your phone number to provide status updates on your visa',
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 110,
                        height: 49,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.blue2,
                              width: 2,
                            ),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: vm.selectedCountryCode,
                            items: vm.countryCodes
                                .map(
                                  (country) => DropdownMenuItem(
                                    value: country['code'],
                                    child: Row(
                                      children: [
                                        Text(
                                          country['flag']!,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          country['code']!,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),

                            onChanged: (value) {
                              vm.changeCountry(value!);
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: vm.phoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: FontSizes.f16),
                          decoration: InputDecoration(
                            hintText: 'xxxxxxxxxx',
                            hintStyle: TextStyle(color: AppColors.grey2),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.black),
                            ),
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
                  Spacer(),
                  FRectangleButton(
                    text: 'Next',
                    color: AppColors.blue3,
                    onPressed: () async {
                      try {
                        await vm
                            .savePhoneNumber(); // Save phone number to Firestore
                        Nav.push(context, BirthDateScreen()); // Go to next page
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
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
