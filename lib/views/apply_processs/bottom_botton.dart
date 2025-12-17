import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/half_button.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/apply_process_viewmodel.dart';

class BottomButtons extends StatelessWidget {
  final ApplyProcessViewModel vm;

  const BottomButtons({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    if (vm.currentStep == 0) {
      if (vm.photoFile == null) {
        return _uploadButtons();
      } else {
        return _confirmButtons();
      }
    }
    return _defaultButtons();
  }

  Widget _uploadButtons() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: ActionButton(
              text: 'Upload',
              bgColor: AppColors.blue,
              textColor: AppColors.blue1,
              imageIcon: AssetImage('assets/home/upload.png'),
              imageIconColor: AppColors.blue2,
              onTap: () => vm.pickFromGallery(true),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ActionButton(
              text: 'live Capture',
              bgColor: AppColors.grey,
              textColor: AppColors.black,
              imageIcon: AssetImage('assets/home/applyphoto.png'),
              onTap: () => vm.pickFromCamera(true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmButtons() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: ActionButton(
              text: 'Retake',
              bgColor: AppColors.white,
              textColor: AppColors.blue2,
              icon: Icons.refresh,
              iconColor: AppColors.blue2,
              onTap: vm.removePhoto,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ActionButton(
              text: 'Confirm',
              bgColor: AppColors.blue2,
              textColor: AppColors.white,
              icon: Icons.check,
              onTap: vm.nextStep,
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultButtons() {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ActionButton(
              text: vm.currentStep == 3 ? 'Submit' : 'Confirm',
              bgColor: AppColors.blue1,
              textColor: AppColors.white,
              // imageIcon: AssetImage('assets/home/upload.png'),
              imageIconColor: AppColors.blue2,
              onTap: vm.nextStep,
            ),
          ),

          SizedBox(height: 12.h),

          // Live Capture Button
          SizedBox(
            width: double.infinity,
            child: ActionButton(
              text: 'Live Capture',
              bgColor: AppColors.grey,
              textColor: AppColors.black,
              imageIcon: AssetImage('assets/home/applyphoto.png'),
              onTap: () {
                // Camera logic based on step
                if (vm.currentStep == 1) {
                  vm.pickFromCamera(false); // passport
                } else if (vm.currentStep == 0) {
                  vm.pickFromCamera(true); // photo
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
