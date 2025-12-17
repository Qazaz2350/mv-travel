import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/view_model/apply_process_viewmodel.dart';
import 'package:provider/provider.dart';
import 'dart:io';
// import 'detail_viewmodel.dart';
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
                  _textField(
                    'Full Name',
                    'Enter your full name',
                    vm.fullNameController,
                  ),
                  SizedBox(height: 16.h),
                  _textField(
                    'Email Address',
                    'you@example.com',
                    vm.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  _dropdownField(
                    context,
                    'Nationality',
                    'Select your nationality',
                    vm.selectedNationality,
                    [
                      'Pakistani',
                      'Indian',
                      'American',
                      'British',
                      'Canadian',
                      'Australian',
                      'Chinese',
                      'Japanese',
                      'German',
                      'French',
                      'Other',
                    ],
                    (value) {
                      vm.selectedNationality = value;
                      vm.notifyListeners();
                    },
                  ),
                  SizedBox(height: 16.h),
                  _textField(
                    'Passport Number',
                    '**** **** **** ****',
                    vm.passportController,
                  ),
                  SizedBox(height: 16.h),
                  _dropdownField(
                    context,
                    'Visa Type',
                    'Travel, student, work, investment',
                    vm.selectedVisaType,
                    [
                      'Travel',
                      'Student',
                      'Work',
                      'Investment',
                      'Business',
                      'Tourist',
                    ],
                    (value) {
                      vm.selectedVisaType = value;
                      vm.notifyListeners();
                    },
                  ),
                  SizedBox(height: 16.h),
                  _textField(
                    'Address',
                    'address home town',
                    vm.addressController,
                    maxLines: 3,
                  ),
                  SizedBox(height: 16.h),
                  _dateField(context, 'Date of Birth', 'mm / dd / yyyy', vm),
                  SizedBox(height: 16.h),
                  _phoneField(vm),
                  SizedBox(height: 16.h),
                  _uploadField(
                    context,
                    'Upload Passport Document',
                    'Accept formats JPG, PNG',
                    vm.passportDocument,
                    vm.passportDocumentName,
                    () => vm.pickImage(true),
                    () {
                      vm.passportDocument = null;
                      vm.passportDocumentName = null;
                      vm.notifyListeners();
                    },
                  ),
                  SizedBox(height: 16.h),
                  _uploadField(
                    context,
                    'Photo',
                    'Accept formats JPG, PNG',
                    vm.photoDocument,
                    vm.photoDocumentName,
                    () => vm.pickImage(false),
                    () {
                      vm.photoDocument = null;
                      vm.photoDocumentName = null;
                      vm.notifyListeners();
                    },
                  ),
                  SizedBox(height: 24.h),
                  _submitButton(context, vm),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ======= Helpers =======

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

  Widget _textField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
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
              borderSide: BorderSide(color: AppColors.blue ?? Colors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
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
              borderSide: BorderSide(color: AppColors.blue ?? Colors.blue),
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

  Widget _dateField(
    BuildContext context,
    String label,
    String hint,
    DetailViewModel vm,
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
        TextField(
          controller: vm.dobController,
          readOnly: true,
          onTap: () => vm.selectDate(context),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.grey2,
              fontSize: FontSizes.f14,
            ),
            filled: true,
            fillColor: AppColors.white,
            prefixIcon: Icon(Icons.calendar_today, color: AppColors.grey2),
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
              borderSide: BorderSide(color: AppColors.blue ?? Colors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _phoneField(DetailViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                    borderSide: BorderSide(
                      color: AppColors.grey2.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.grey2.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.blue ?? Colors.blue,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 14.h,
                  ),
                ),
                items: ['+92', '+91', '+1', '+44', '+971', '+86', '+81']
                    .map(
                      (code) =>
                          DropdownMenuItem(value: code, child: Text(code)),
                    )
                    .toList(),
                onChanged: (value) {
                  vm.selectedCountryCode = value!;
                  vm.notifyListeners();
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 5,
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
                    borderSide: BorderSide(
                      color: AppColors.grey2.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.grey2.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.blue ?? Colors.blue,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _uploadField(
    BuildContext context,
    String label,
    String acceptedFormats,
    File? file,
    String? fileName,
    VoidCallback onTap,
    VoidCallback onRemove,
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
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: file != null
                  ? AppColors.blue?.withOpacity(0.05)
                  : AppColors.white,
              border: Border.all(
                color: file != null
                    ? (AppColors.blue ?? Colors.blue)
                    : AppColors.grey2.withOpacity(0.3),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: file == null
                ? Column(
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 40.sp,
                        color: AppColors.grey2,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Click to upload',
                        style: TextStyle(
                          fontSize: FontSizes.f14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        acceptedFormats,
                        style: TextStyle(
                          fontSize: FontSizes.f12,
                          color: AppColors.grey2,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.blue ?? Colors.blue,
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fileName ?? 'File uploaded',
                              style: TextStyle(
                                fontSize: FontSizes.f14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Tap to change',
                              style: TextStyle(
                                fontSize: FontSizes.f12,
                                color: AppColors.grey2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: onRemove,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context, DetailViewModel vm) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () => vm.submitForm(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue ?? Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          'Submit Application',
          style: TextStyle(
            fontSize: FontSizes.f16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
