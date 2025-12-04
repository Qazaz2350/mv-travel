import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SkipButton({
    super.key,
    required this.onPressed, // <-- made required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: 73.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.blue1,
      ),
      child: TextButton(
        onPressed: onPressed, // <-- using the required callback
        child: Text(
          'Skip',
          style: TextStyle(
            color: AppColors.white,
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
