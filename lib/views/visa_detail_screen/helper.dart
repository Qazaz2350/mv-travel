import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/colors.dart';

Widget buildInfoRow(
  String label1,
  String value1,
  String label2,
  String value2,
) {
  return Row(
    children: [
      Expanded(
        child: Row(
          children: [
            Text(
              label1,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.grey2,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              value1,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            Text(
              label2,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.grey2,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              value2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildDocumentItem(String title, String subtitle) {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: AppColors.white,
    ),
    child: Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.green1.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: ImageIcon(
            AssetImage('assets/home/tik.png'),
            color: AppColors.green1,
            size: 24.w,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.grey2,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
