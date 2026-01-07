import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/half_button.dart';
import 'package:mvtravel/utilis/Nav.dart';
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
    if (vm.currentStep == 2) {
      return _thirdStepConfirm(context);
    }

    if (vm.currentStep == 0) {
      if (vm.photoFile == null) {
        return _uploadButtons();
      } else {
        return _confirmButtons(context);
      }
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

          // ✅ Upload files first if not uploaded yet
          if (detailVM.photoDocument != null ||
              detailVM.passportDocument != null) {
            final uploadVM = ApplyProcessViewModel();

            if (detailVM.photoDocument != null) {
              final url = await uploadVM.uploadFileToFirebase(
                detailVM.photoDocument!,
                'user_photos',
              );
              debugPrint('Photo uploaded: $url');
            }

            if (detailVM.passportDocument != null) {
              final url = await uploadVM.uploadFileToFirebase(
                detailVM.passportDocument!,
                'user_passports',
              );
              debugPrint('Passport uploaded: $url');
            }
          }

          // Submit form with validation
          await detailVM.submitFormWithValidation(
            context,
            country: country,
            city: city,
            flag: flag,
          );

          if (detailVM.validateForm()) {
            // Move to next step
            vm.nextStep(context);

            // Fetch visas after submission
            context.read<VisaTrackingViewModel>().fetchVisas();

            // Clear the form
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
              onTap: () => vm.nextStep(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultButtons(BuildContext context) {
    if (vm.currentStep == 3) {
      return Container(
        width: double.infinity,
        color: AppColors.white,
        padding: EdgeInsets.all(16.w),
        child: SizedBox(
          width: double.infinity,
          child: ActionButton(
            text: ' Confirm Your Apply',
            bgColor: AppColors.blue2,
            textColor: AppColors.white,
            onTap: () async {
              final detailVM = context.read<DetailViewModel>();

              // ✅ Upload files if they exist
              if (detailVM.photoDocument != null ||
                  detailVM.passportDocument != null) {
                final uploadVM = ApplyProcessViewModel();

                if (detailVM.photoDocument != null) {
                  final url = await uploadVM.uploadFileToFirebase(
                    detailVM.photoDocument!,
                    'user_photos',
                  );
                  debugPrint('Photo uploaded: $url');
                }

                if (detailVM.passportDocument != null) {
                  final url = await uploadVM.uploadFileToFirebase(
                    detailVM.passportDocument!,
                    'user_passports',
                  );
                  debugPrint('Passport uploaded: $url');
                }
              }

              // Navigate to Home
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
              textColor: AppColors.black,
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
