import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/filters_viewmodel.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final FiltersViewModel viewModel;

  const StatusChip({Key? key, required this.label, required this.viewModel})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = viewModel.selectedStatuses.contains(label);
    return GestureDetector(
      onTap: () {
        viewModel.toggleStatus(label);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blue1 : AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.blue1 : AppColors.grey1,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.black,
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
