import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

Widget extraPickBox({required String title, required VoidCallback onTap}) {
  return Container(
    // color: AppColors.blue3,
    padding: EdgeInsets.symmetric(vertical: 10.h),
    margin: EdgeInsets.symmetric(horizontal: 10.h),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.transparent),
    ),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 23.w),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.grey2),
          color: AppColors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload_file_outlined, color: AppColors.black),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
