import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class SelectTile extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const SelectTile({
    Key? key,
    required this.label,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.black,
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: AppColors.grey2,
                    fontSize: FontSizes.f14,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.chevron_right, size: 20.sp, color: AppColors.grey2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
