import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/filters_viewmodel.dart';

class RegionPicker {
  static void show(
    BuildContext context,
    FiltersViewModel viewModel,
    bool isFirstRegion,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Region',
                      style: TextStyle(
                        fontSize: FontSizes.f20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, size: 24.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Divider(height: 1, color: AppColors.grey1),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.regions.length,
                  itemBuilder: (context, index) {
                    final region = viewModel.regions[index];
                    final currentRegion = isFirstRegion
                        ? viewModel.selectedRegion
                        : viewModel.selectedRegion2;
                    final isSelected = currentRegion == region;
                    return InkWell(
                      onTap: () {
                        viewModel.setRegion(
                          isFirst: isFirstRegion,
                          region: region,
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.blue1.withOpacity(0.1)
                              : AppColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              region,
                              style: TextStyle(
                                fontSize: FontSizes.f16,
                                color: isSelected
                                    ? AppColors.blue2
                                    : AppColors.black,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check,
                                color: AppColors.blue2,
                                size: 20.sp,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
