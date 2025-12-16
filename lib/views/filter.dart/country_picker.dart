import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/filters_viewmodel.dart';

class CountryPicker {
  static void show(BuildContext context, FiltersViewModel viewModel) {
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
                      'Select Country',
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
                  itemCount: viewModel.countries.length,
                  itemBuilder: (context, index) {
                    final country = viewModel.countries[index];
                    final isSelected = viewModel.selectedCountry == country;
                    return InkWell(
                      onTap: () {
                        viewModel.setCountry(country);
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
                              country,
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
