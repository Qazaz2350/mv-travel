import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/half_button.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/apply_process_viewmodel.dart';
import 'package:mvtravel/view_model/visa_tracking_view_model.dart';
import 'package:mvtravel/views/home/home_dashboard.dart';
import 'package:provider/provider.dart';

class BottomButtons extends StatelessWidget {
  final ApplyProcessViewModel vm;
  final String country;
  final String city;
  final String flag;

  const BottomButtons({
    super.key,
    required this.vm,
    required this.country,
    required this.city,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    if (vm.currentStep == 2) return _thirdStepConfirm(context);
    if (vm.currentStep == 0) {
      return vm.photoFile == null ? _uploadButtons() : _confirmButtons(context);
    }
    return _defaultButtons(context);
  }

  Widget _thirdStepConfirm(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      child: ActionButton(
        text: 'Continue',
        bgColor: AppColors.blue2,
        textColor: AppColors.white,
        onTap: () async {
          final detailVM = context.read<DetailViewModel>();

          if ((detailVM.photoDocument != null && vm.photoUrl == null) ||
              (detailVM.passportDocument != null && vm.passportUrl == null)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Uploading files, please wait...')),
            );
            return;
          }

          await detailVM.submitFormWithValidation(
            context,
            country: country,
            city: city,
            flag: flag,
          );

          if (detailVM.validateForm()) {
            vm.nextStep(context);
            context.read<VisaTrackingViewModel>().fetchVisas();
            detailVM.clearForm();
          }
        },
      ),
    );
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
              text: 'Live Capture',
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

  Widget _confirmButtons(BuildContext context) {
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
              onTap: () {
                if (vm.photoFile != null && vm.photoUrl == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Photo is still uploading, please wait...'),
                    ),
                  );
                  return;
                }
                vm.nextStep(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultButtons(BuildContext context) {
    // ✅ Step 3: Confirm Payment — NO Firestore write, only navigate
    if (vm.currentStep == 3) {
      return Container(
        width: double.infinity,
        color: AppColors.white,
        padding: EdgeInsets.all(16.w),
        child: SizedBox(
          width: double.infinity,
          child: ActionButton(
            text: 'Confirm Your Payment',
            bgColor: AppColors.blue2,
            textColor: AppColors.white,
            onTap: () {
              // Simply navigate to Home
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePageView()),
                (route) => false,
              );
            },
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ActionButton(
              text: 'Confirm',
              bgColor: AppColors.blue1,
              textColor: AppColors.white,
              imageIconColor: AppColors.blue2,
              onTap: () {
                if ((vm.currentStep == 0 && vm.photoFile != null) ||
                    (vm.currentStep == 1 && vm.passportFile != null)) {
                  if ((vm.currentStep == 0 && vm.photoUrl == null) ||
                      (vm.currentStep == 1 && vm.passportUrl == null)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'File is still uploading, please wait...',
                        ),
                      ),
                    );
                    return;
                  }
                  vm.nextStep(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please upload the file first'),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: ActionButton(
              text: 'Live Capture',
              bgColor: AppColors.grey,
              textColor: Colors.black,
              imageIcon: AssetImage('assets/home/applyphoto.png'),
              onTap: () {
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
