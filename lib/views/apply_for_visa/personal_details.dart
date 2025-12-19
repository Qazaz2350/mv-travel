// ignore_for_file: invalid_use_of_protected_member, dead_code, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/app_date_field.dart';
import 'package:mvtravel/commen/app_text_field.dart';
import 'package:mvtravel/views/apply_for_visa/app_lists.dart';
import 'package:provider/provider.dart';

import 'package:mvtravel/view_model/apply_process_viewmodel.dart';
import 'package:mvtravel/views/apply_for_visa/upload_container.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class DetailStepView extends StatelessWidget {
  const DetailStepView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailViewModel(),
      child: Consumer<DetailViewModel>(
        builder: (context, vm, child) {
          return _card(
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    label: 'Date of Birth',
                    hint: 'mm / dd / yyyy',
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
                    fileName: vm.passportDocumentName,
                    onTap: () => vm.pickImage(true),
                    onRemove: () {
                      vm.passportDocument = null;
                      vm.passportDocumentName = null;
                      vm.notifyListeners();
                    },
                  ),
                  SizedBox(height: 16.h),

                  /// Photo Upload
                  UploadFieldWidget(
                    label: 'Photo',
                    acceptedFormats: 'Accept formats JPG, PNG',
                    file: vm.photoDocument,
                    fileName: vm.photoDocumentName,
                    onTap: () => vm.pickImage(false),
                    onRemove: () {
                      vm.photoDocument = null;
                      vm.photoDocumentName = null;
                      vm.notifyListeners();
                    },
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
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
        DropdownButtonFormField<String>(
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
              borderSide: BorderSide(color: AppColors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _phoneField(DetailViewModel vm) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            value: vm.selectedCountryCode,
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
                horizontal: 12.w,
                vertical: 14.h,
              ),
            ),
            items: ['+92', '+91', '+1', '+44', '+971', '+86', '+81']
                .map((code) => DropdownMenuItem(value: code, child: Text(code)))
                .toList(),
            onChanged: (value) {
              vm.selectedCountryCode = value!;
              vm.notifyListeners();
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
              hintText: '312 456 789',
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
