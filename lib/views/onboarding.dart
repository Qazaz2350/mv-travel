// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mvtravel/model/onboarding_model.dart';
import 'package:mvtravel/view_model/onboarding_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/views/auth/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: Consumer<OnboardingViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            body: Stack(
              children: [
                // PageView
                PageView.builder(
                  controller: vm.pageController,
                  onPageChanged: vm.onPageChanged,
                  itemCount: vm.pages.length,
                  itemBuilder: (context, index) {
                    return OnboardingPage(data: vm.pages[index]);
                  },
                ),

                // Top Bar (Back and Skip)
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (vm.currentPage > 0)
                          GestureDetector(
                            onTap: vm.previousPage,
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          )
                        else
                          SizedBox(width: 40.w),

                        if (vm.currentPage < vm.pages.length - 1)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.blue1,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.f14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(width: 80.w),
                      ],
                    ),
                  ),
                ),

                // Bottom Content
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 30.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            vm.pages[vm.currentPage].title,
                            style: TextStyle(
                              fontSize: FontSizes.f28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            vm.pages[vm.currentPage].description,
                            style: TextStyle(
                              fontSize: FontSizes.f16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              vm.pages.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                width: vm.currentPage == index ? 40.w : 8.w,
                                height: 8.h,
                                decoration: BoxDecoration(
                                  color: vm.currentPage == index
                                      ? AppColors.blue1
                                      : Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          SizedBox(
                            width: double.infinity,
                            child: FRectangleButton(
                              text: vm.currentPage < vm.pages.length - 1
                                  ? "Next"
                                  : "Get Started",
                              color: AppColors.blue1,
                              onPressed: vm.currentPage < vm.pages.length - 1
                                  ? vm.nextPage
                                  : () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const SignUpScreen(),
                                        ),
                                      );
                                    },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          data.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Container(color: AppColors.blue2),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
