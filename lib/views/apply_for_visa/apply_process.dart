import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/views/apply_for_visa/extrapickbox.dart';
import 'package:mvtravel/views/apply_for_visa/payment_view.dart';
import 'package:mvtravel/views/apply_for_visa/bottom_botton.dart';
import 'package:mvtravel/views/apply_for_visa/personal_details.dart';
import 'package:mvtravel/views/apply_for_visa/upload_card.dart';
import 'package:mvtravel/views/home/passport_documents_view.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/apply_process_viewmodel.dart';

class ApplyProcess extends StatelessWidget {
  final String country;
  final String city;
  final String flag;

  const ApplyProcess({
    super.key,
    required this.country,
    required this.city,
    required this.flag,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApplyProcessViewModel(),
      child: _ApplyProcessView(country: country, city: city, flag: flag),
    );
  }
}

class _ApplyProcessView extends StatelessWidget {
  final String country;
  final String city;
  final String flag;

  const _ApplyProcessView({
    required this.country,
    required this.city,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ApplyProcessViewModel>();

    return WillPopScope(
      onWillPop: () async {
        if (vm.currentStep > 0) {
          vm.previousStep(); // 👈 previous _buildStepItem par jayega
          return false; // ❌ screen pop nahi hogi
        }
        return true; // ✅ agar step 0 hai to screen pop ho
      },
      child: Scaffold(
        backgroundColor: AppColors.grey,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: () {
              if (vm.currentStep > 0) {
                vm.previousStep(); // 👈 same logic for appbar back
              } else {
                Nav.pop(context);
              }
            },
          ),
          title: Text(
            'Apply for visa',
            style: TextStyle(
              color: AppColors.black,
              fontSize: FontSizes.f20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),

        body: Column(
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  color: AppColors.white,
                  child: _buildStepper(vm),
                ),
              ),
            ),
            // Text('${country}${city}', style: TextStyle(fontSize: FontSizes.f16)),
            SizedBox(height: 16.h),
            Expanded(
              child: _buildStepContent(
                vm,
                context,
                country: country,
                city: city,
                flag: flag,
              ),
            ),
            BottomButtons(vm: vm, country: country, city: city, flag: flag),
          ],
        ),
      ),
    );
  }

  // ================= STEPPER =================

  Widget _buildStepper(ApplyProcessViewModel vm) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        children: [
          _buildStepItem(vm, "assets/home/face.png", 'Photo', 0),
          _buildStepLine(vm, 0),
          _buildStepItem(vm, "assets/home/passport.png", 'Passport', 1),
          _buildStepLine(vm, 1),
          _buildStepItem(vm, "assets/home/details.png", 'Detail', 2),
          _buildStepLine(vm, 2),
          _buildStepItem(vm, "assets/home/checkout.png", 'Checkout', 3),
        ],
      ),
    );
  }

  Widget _buildStepItem(
    ApplyProcessViewModel vm,
    String image,
    String label,
    int index,
  ) {
    final isActive = vm.currentStep == index;
    final isCompleted = vm.currentStep > index;

    return Expanded(
      child: Column(
        children: [
          ImageIcon(
            AssetImage(image),
            size: 16.sp,
            color: isActive || isCompleted ? AppColors.blue2 : AppColors.grey1,
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontSize: FontSizes.f12,
              color: isActive ? AppColors.blue2 : AppColors.grey2,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepLine(ApplyProcessViewModel vm, int index) {
    return Container(
      width: 20.w,
      height: 2.h,
      margin: EdgeInsets.only(bottom: 20.h),
      color: vm.currentStep > index ? AppColors.blue2 : AppColors.grey1,
    );
  }

  // ================= CONTENT =================

  Widget _buildStepContent(
    ApplyProcessViewModel vm,
    BuildContext context, {
    required String country,
    required String city,
    required String flag,
  }) {
    switch (vm.currentStep) {
      case 0:
        return Column(
          children: [
            UploadCard(
              title: 'Upload Photo',
              description:
                  'Make sure the image is well-lit, in focus, and shows all details clearly',
              file: vm.photoFile,
              isUploading: vm.photoFile != null && vm.photoUrl == null,
              onRemove: vm.removePhoto,
              onCamera: () => vm.pickFromCamera(true),
              onGallery: () => vm.pickFromGallery(true),
            ),

            // SizedBox(height: 12.h),
            if (vm.photoFile == null) ...[
              extraPickBox(
                title: 'Select from uploaded documents',
                onTap: () async {
                  final file = await Navigator.push<File?>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PassportDocumentsView(),
                    ),
                  );

                  if (file != null) {
                    vm.setPhotoFromFile(file);
                  }
                },
              ),
            ],
          ],
        );

      case 1:
        return Column(
          children: [
            UploadCard(
              title: 'Upload Passport',
              description:
                  'Please upload a clear copy of your passport. Make sure all details are visible.',
              file: vm.passportFile,
              isUploading: vm.passportFile != null && vm.passportUrl == null,
              onRemove: vm.removePassport,
              onCamera: () => vm.pickFromCamera(false),
              onGallery: () => vm.pickFromGallery(false),
            ),

            // SizedBox(height: 12.h),
            if (vm.passportFile == null) ...[
              extraPickBox(
                title: 'Select from uploaded documents',
                onTap: () async {
                  final file = await Navigator.push<File?>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PassportDocumentsView(),
                    ),
                  );

                  if (file != null) {
                    vm.setPassportFromFile(file);
                  }
                },
              ),
            ],
          ],
        );

      case 2:
        return DetailStepView(country: country, city: city, flag: flag);

      case 3:
        return Paymentdetails();

      default:
        return const SizedBox();
    }
  }

  // ================= HELPERS =================
}
