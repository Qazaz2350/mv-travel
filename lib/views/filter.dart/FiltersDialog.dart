import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/half_button.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/views/filter.dart/tabbar.dart';

class FiltersDialog extends StatefulWidget {
  const FiltersDialog({Key? key}) : super(key: key);

  @override
  State<FiltersDialog> createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  late VoidCallback _vmListener;

  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.only(top: 50.h, bottom: 0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 50.h,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: FontSizes.f20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.grey),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visa Type',
                      style: TextStyle(
                        fontSize: FontSizes.f16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Expanded(child: FilterTabsScreen()),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(color: AppColors.grey),
              child: Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      textColor: AppColors.blue2,
                      text: "Clear Filters",
                      bgColor: AppColors.white,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ActionButton(
                      textColor: AppColors.white,
                      text: "Apply Filters",
                      bgColor: AppColors.blue3,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
