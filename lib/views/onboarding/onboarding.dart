// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mvtravel/model/onboarding/onboarding_model.dart';
import 'package:mvtravel/view_model/onboarding/onboarding_viewmodel.dart';
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
                // PageView only for images
                PageView.builder(
                  controller: vm.pageController,
                  onPageChanged: vm.onPageChanged,
                  itemCount: vm.pages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      vm.pages[index].image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: AppColors.blue2),
                    );
                  },
                ),

                // Overlay: gradient + text + button
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
                          // TEXT AREA: Swipe forwards to PageView
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onHorizontalDragUpdate: (details) {
                              vm.pageController.position.moveTo(
                                vm.pageController.position.pixels -
                                    details.delta.dx,
                              );
                            },
                            child: Column(
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
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                      ),
                                      width: vm.currentPage == index
                                          ? 40.w
                                          : 8.w,
                                      height: 8.h,
                                      decoration: BoxDecoration(
                                        color: vm.currentPage == index
                                            ? AppColors.blue1
                                            : Colors.white.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ),

                          // BUTTON AREA: no swipe, only clickable
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
