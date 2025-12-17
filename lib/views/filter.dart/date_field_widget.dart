import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
// import 'package:mvtravel/view_model/filters_viewmodel.dart';

class DateFieldWidget extends StatelessWidget {
  final String label;
  final DateTime? date;
  final bool isFrom;
  final Function(bool isFrom) onTapDate;

  const DateFieldWidget({
    Key? key,
    required this.label,
    required this.date,
    required this.isFrom,
    required this.onTapDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.black,
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => onTapDate(isFrom),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18.sp,
                  color: AppColors.grey2,
                ),
                SizedBox(width: 8.w),
                Text(
                  date != null
                      ? '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}'
                      : 'dd/mm/yyyy',
                  style: TextStyle(
                    color: date != null ? AppColors.black : AppColors.grey2,
                    fontSize: FontSizes.f14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
