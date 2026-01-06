// ignore_for_file: invalid_use_of_protected_member, dead_code, invalid_use_of_visible_for_testing_member, prefer_null_aware_operators
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mvtravel/commen/app_text_field.dart';
import 'package:mvtravel/views/apply_for_visa/app_lists.dart';
import 'package:mvtravel/widgets/calender.dart';
import 'package:provider/provider.dart';

import 'package:mvtravel/view_model/apply_process_viewmodel.dart';
import 'package:mvtravel/views/apply_for_visa/upload_container.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class DetailStepView extends StatelessWidget {
  final String country;
  final String city;
  final String flag;

  const DetailStepView({
    super.key,
    required this.country,
    required this.city,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DetailViewModel>(); // shared instance

    return _card(
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Selected country: ",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: FontSizes.f12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.blue2.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: AppColors.blue2, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.5),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "$country, $city",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: FontSizes.f12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            /// Full Name
            AppTextField(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: vm.fullNameController,
            ),
            SizedBox(height: 16.h),

            /// Email
            AppTextField(
              label: 'Email Address',
              hint: 'you@example.com',
              controller: vm.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.h),

            /// Nationality
            _dropdownField(
              context,
              'Nationality',
              'Select your nationality',
              vm.selectedNationality,
              AppLists.nationalities,
              (value) {
                vm.selectedNationality = value;
                vm.notifyListeners();
              },
            ),
            SizedBox(height: 16.h),

            /// Passport Number
            AppTextField(
              label: 'Passport Number',
              hint: '**** **** **** ****',
              controller: vm.passportController,
            ),
            SizedBox(height: 16.h),

            /// Visa Type
            _dropdownField(
              context,
              'Visa Type',
              'Travel, student, work, investment',
              vm.selectedVisaType,
              AppLists.visaTypes,
              (value) {
                vm.selectedVisaType = value;
                vm.notifyListeners();
              },
            ),
            SizedBox(height: 16.h),

            /// Address
            AppTextField(
              label: 'Address',
              hint: 'address home town',
              controller: vm.addressController,
              maxLines: 3,
            ),
            SizedBox(height: 16.h),

            /// Date of Birth
            AppDateField(
              label: 'Birth Date',
              hint: 'Select your birth date',
              controller: vm.dobController,
              onTap: () => vm.selectDate(context),
            ),
            SizedBox(height: 16.h),

            /// Phone
            _phoneField(vm),
            SizedBox(height: 16.h),

            /// Passport Upload
            UploadFieldWidget(
              label: 'Upload Passport Document',
              acceptedFormats: 'Accept formats JPG, PNG',
              file: vm.passportDocument,
              fileName: vm.passportDocument != null
                  ? vm.passportDocument!.path.split('/').last
                  : null,
              onTap: () => vm.pickImage(true),
              onRemove: () {
                vm.passportDocument = null;
                vm.notifyListeners();
              },
            ),
            SizedBox(height: 16.h),

            /// Photo Upload
            UploadFieldWidget(
              label: 'Photo',
              acceptedFormats: 'Accept formats JPG, PNG',
              file: vm.photoDocument,
              fileName: vm.photoDocument != null
                  ? vm.photoDocument!.path.split('/').last
                  : null,
              onTap: () => vm.pickImage(false),
              onRemove: () {
                vm.photoDocument = null;
                vm.notifyListeners();
              },
            ),
            SizedBox(height: 24.h),

            /// Confirm Button
            // Center(
            //   child: SizedBox(
            //     width: double.infinity,
            //     height: 35.h,
            //     child: ElevatedButton(
            //       onPressed: () => vm.submitForm(context),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.blue2,
            //         foregroundColor: Colors.white,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20.r),
            //         ),
            //       ),
            //       child: const Text(
            //         'save ',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // ================= HELPERS =================

  Widget _card(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child,
    );
  }

  Widget _dropdownField(
    BuildContext context,
    String label,
    String hint,
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField2<String>(
          isExpanded: true,

          value: value,
          hint: Text(
            hint,
            style: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey1),
            ),
            contentPadding: EdgeInsets.symmetric(
              // horizontal: 16.w,
              // vertical: 14.h,
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item, style: TextStyle(fontSize: FontSizes.f14)),
                ),
              )
              .toList(),
          onChanged: onChanged,
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300.h, // adjust height here
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.white,
            ),
            offset: Offset(0, 0), // opens below the field
          ),
        ),
      ],
    );
  }

  Widget _phoneField(DetailViewModel vm) {
    // Ensure selectedCountryCode exists in the list
    final isValidCode = AppLists.countries.any(
      (c) => c['code'] == vm.selectedCountryCode,
    );
    if (!isValidCode) {
      vm.selectedCountryCode = AppLists.countries.first['code']!;
    }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: DropdownButtonFormField2<String>(
            isExpanded: true,
            value: vm.selectedCountryCode, // store only code

            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.blue),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 14.h,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            items: AppLists.countries
                .map(
                  (country) => DropdownMenuItem(
                    value: country['code'], // only code is stored
                    child: Text(
                      "${country['flag']} (${country['code']})", // UI shows flag
                      style: TextStyle(
                        fontSize: FontSizes.f14,
                        color: AppColors.grey2,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                vm.selectedCountryCode = value; // update ViewModel directly
                vm.notifyListeners();
              }
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 4,
          child: TextField(
            controller: vm.phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'xxx-xxx-xxxx',
              hintStyle: TextStyle(
                color: AppColors.grey2,
                fontSize: FontSizes.f14,
              ),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.blue),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
