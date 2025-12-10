import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
// import 'package:mvtravel/utilis/AppColors.dart';
import 'package:mvtravel/utilis/colors.dart';

class LoadingScreenView extends StatefulWidget {
  const LoadingScreenView({Key? key}) : super(key: key);

  @override
  State<LoadingScreenView> createState() => _LoadingScreenViewState();
}

class _LoadingScreenViewState extends State<LoadingScreenView> {
  @override
  void initState() {
    super.initState();
    // Simulate loading and navigation
    _navigateAfterLoading();
  }

  Future<void> _navigateAfterLoading() async {
    // Wait for 3 seconds (or until your actual loading is complete)
    await Future.delayed(const Duration(seconds: 3));
    
    // Navigate to next screen
    if (mounted) {
      // Nav.push(context, YourNextScreen());
      // or Nav.pushReplacement(context, YourNextScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                'MB Travel Consultants',
                style: TextStyle(
                  fontSize: FontSizes.f20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),

            // Spacer to center content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Lottie Animation
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

                  SizedBox(height: 40.h),

                  // Loading Text Container
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 32.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 32.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Main loading text
                        Text(
                          'Loading your personalized',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: FontSizes.f20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          'visa experience...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: FontSizes.f20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Subtitle text
                        Text(
                          'Optimizing travel routes and',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: FontSizes.f14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey2,
                          ),
                        ),
                        Text(
                          'documents',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: FontSizes.f14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey2,
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Progress bar
                        Container(
                          width: double.infinity,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedProgressBar(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

// Animated Progress Bar Widget
class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({Key? key}) : super(key: key);

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return FractionallySizedBox(
          widthFactor: _animation.value,
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: AppColors.blue1,
              borderRadius: BorderRadius.circular(3.r),
              gradient: LinearGradient(
                colors: [
                  AppColors.blue1,
                  AppColors.blue2,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}