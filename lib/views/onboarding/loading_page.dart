import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mvtravel/model/onboarding/loading_screen_model.dart';
import 'package:mvtravel/view_model/onboarding/loading_screen_viewmodel.dart';
import 'package:mvtravel/views/home/home_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class LoadingScreenView extends StatelessWidget {
  const LoadingScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = LoadingScreenModel();

    return ChangeNotifierProvider(
      create: (_) => LoadingScreenViewModel()
        ..startLoading(() {
          // Navigation after loading
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePageView()),
          );
        }),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text(
                  model.title,
                  style: TextStyle(
                    fontSize: FontSizes.f20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LottieWithSpinner(),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Consumer<LoadingScreenViewModel>(
                        builder: (context, vm, _) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 32.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  model.mainText1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: FontSizes.f20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                ),
                                Text(
                                  model.mainText2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: FontSizes.f20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  model.subText1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: FontSizes.f14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey2,
                                  ),
                                ),
                                Text(
                                  model.subText2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: FontSizes.f14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey2,
                                  ),
                                ),
                                SizedBox(height: 24.h),
                                Container(
                                  width: double.infinity,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: vm.progress,
                                      child: Container(
                                        height: 6.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.blue1,
                                          borderRadius: BorderRadius.circular(
                                            3.r,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.blue1,
                                              AppColors.blue2,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Lottie with Spinner -------------------
class LottieWithSpinner extends StatefulWidget {
  const LottieWithSpinner({Key? key}) : super(key: key);

  @override
  State<LottieWithSpinner> createState() => _LottieWithSpinnerState();
}

class _LottieWithSpinnerState extends State<LottieWithSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      height: 280.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: _controller,
            child: SizedBox(
              width: 300.w,
              height: 300.h,
              child: CircularProgressIndicator(
                strokeWidth: 6.w,
                valueColor: AlwaysStoppedAnimation(AppColors.blue1),
                backgroundColor: AppColors.grey.withOpacity(0.2),
              ),
            ),
          ),
          Container(
            width: 280.w,
            height: 280.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue1.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Lottie.asset(
                'assets/lottie/loading.json',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
