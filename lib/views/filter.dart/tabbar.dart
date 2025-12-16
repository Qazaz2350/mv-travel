import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/filters_viewmodel.dart';

class FilterTabbar extends StatelessWidget {
  final String label;
  final FiltersViewModel viewModel;

  const FilterTabbar({Key? key, required this.label, required this.viewModel})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = viewModel.selectedVisaType == label;
    return GestureDetector(
      onTap: () {
        viewModel.selectVisaType(label);
      },
      child: Container(
        
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blue1 : AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
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
