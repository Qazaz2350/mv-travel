import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/view_model/apply_process_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';

class ApplyProcess extends StatelessWidget {
  const ApplyProcess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApplyProcessViewModel(),
      child: const _ApplyProcessView(),
    );
  }
}

class _ApplyProcessView extends StatelessWidget {
  const _ApplyProcessView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ApplyProcessViewModel>();

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Nav.pop(context),
        ),
        title: Text(
          'Apply to Germany',
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
                color: Colors.white, // ✅ apply color here
                child: _buildStepper(vm),
              ),
            ),
          ),

          SizedBox(height: 16.h),
          Expanded(child: _buildStepContent(vm, context)),
          _buildBottomButtons(vm, context),
        ],
      ),
    );
  }

  // ================= STEPPER =================

  Widget _buildStepper(ApplyProcessViewModel vm) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        children: [
          _buildStepItem(vm, "assets/home/applyphoto.png", 'Photo', 0),
          _buildStepLine(vm, 0),
          _buildStepItem(vm, "assets/home/applypassport.png", 'Passport', 1),
          _buildStepLine(vm, 1),
          _buildStepItem(vm, "assets/home/applyuser.png", 'Detail', 2),
          _buildStepLine(vm, 2),
          _buildStepItem(vm, "assets/home/applycheckout.png", 'Checkout', 3),
        ],
      ),
    );
  }

  Widget _buildStepItem(
    ApplyProcessViewModel vm,
    String image, // REQUIRED
    String label,
    int index,
  ) {
    final isActive = vm.currentStep == index;
    final isCompleted = vm.currentStep > index;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(),
            child: ImageIcon(
              AssetImage(image), // ✅ using required image
              size: 16.sp,
              color: isActive || isCompleted
                  ? AppColors.blue2
                  : AppColors.grey1,
            ),
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

  Widget _buildStepContent(ApplyProcessViewModel vm, BuildContext context) {
    switch (vm.currentStep) {
      case 0:
        return _photoStep(vm, context);
      case 1:
        return _passportStep(vm, context);
      case 2:
        return _detailStep();
      case 3:
        return _checkoutStep(vm);
      default:
        return _photoStep(vm, context);
    }
  }

  Widget _photoStep(ApplyProcessViewModel vm, BuildContext context) {
    return _uploadCard(
      title: 'Upload Photo',
      description:
          'Lorem ipsum dolor sit amet consectetur. Vestibulum malesuada in amet urna.',
      file: vm.photoFile,
      onRemove: vm.removePhoto,
      onTap: () => _showUploadOptions(context, vm, true),
    );
  }

  Widget _passportStep(ApplyProcessViewModel vm, BuildContext context) {
    return _uploadCard(
      title: 'Upload Passport',
      description:
          'Please upload a clear copy of your passport. Make sure all details are visible.',
      file: vm.passportFile,
      onRemove: vm.removePassport,
      onTap: () => _showUploadOptions(context, vm, false),
    );
  }

  Widget _detailStep() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Personal Details'),
          _desc('Please fill in your personal information.'),
          SizedBox(height: 24.h),
          _textField('Full Name', 'Enter your full name'),
          SizedBox(height: 16.h),
          _textField('Date of Birth', 'DD/MM/YYYY'),
          SizedBox(height: 16.h),
          _textField('Nationality', 'Enter your nationality'),
          SizedBox(height: 16.h),
          _textField('Phone Number', '+92 xxx xxx xxxx'),
        ],
      ),
    );
  }

  Widget _checkoutStep(ApplyProcessViewModel vm) {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Review & Checkout'),
          _desc('Please review your application before submitting.'),
          SizedBox(height: 24.h),
          _reviewItem(
            'Photo',
            vm.photoFile != null ? 'Uploaded ✓' : 'Not uploaded',
          ),
          SizedBox(height: 12.h),
          _reviewItem(
            'Passport',
            vm.passportFile != null ? 'Uploaded ✓' : 'Not uploaded',
          ),
          SizedBox(height: 12.h),
          _reviewItem('Personal Details', 'Completed ✓'),
        ],
      ),
    );
  }

  // ================= BOTTOM =================

  Widget _buildBottomButtons(ApplyProcessViewModel vm, BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          if (vm.currentStep > 0)
            Expanded( 
              child: ElevatedButton(
                onPressed: vm.previousStep,
                child: const Text('Back'),
              ),
            ),
          if (vm.currentStep > 0) SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton(
              onPressed: vm.nextStep,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue2),
              child: Text(vm.currentStep == 3 ? 'Submit' : 'Continue'),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HELPERS =================

  Widget _uploadCard({
    required String title,
    required String description,
    required File? file,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(title),
          _desc(description),
          SizedBox(height: 24.h),
          file == null
              ? GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 48.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey1, width: 2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: const Center(child: Text('Tap to Upload')),
                  ),
                )
              : _filePreview(file, onRemove),
        ],
      ),
    );
  }

  Widget _filePreview(File file, VoidCallback onRemove) {
    return ListTile(
      leading: Image.file(file, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(file.path.split('/').last),
      trailing: IconButton(icon: const Icon(Icons.close), onPressed: onRemove),
    );
  }

  Widget _card(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child,
    );
  }

  Widget _title(String text) => Text(
    text,
    style: TextStyle(fontSize: FontSizes.f20, fontWeight: FontWeight.w700),
  );

  Widget _desc(String text) => Text(
    text,
    style: TextStyle(fontSize: FontSizes.f14, color: AppColors.grey2),
  );

  Widget _textField(String label, String hint) {
    return TextField(
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }

  Widget _reviewItem(String title, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(status)],
    );
  }

  void _showUploadOptions(
    BuildContext context,
    ApplyProcessViewModel vm,
    bool isPhoto,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Gallery'),
            onTap: () {
              Nav.pop(context);
              vm.pickFromGallery(isPhoto);
            },
          ),
          ListTile(
            title: const Text('Camera'),
            onTap: () {
              Nav.pop(context);
              vm.pickFromCamera(isPhoto);
            },
          ),
        ],
      ),
    );
  }
}
