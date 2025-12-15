import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/model/home_page_model.dart';

class CategoryTabsWidget extends StatelessWidget {
  final HomePageViewModel viewModel;

  const CategoryTabsWidget({Key? key, required this.viewModel})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),

      child: Row(
        children: VisaCategory.values.map((category) {
          final isSelected = viewModel.selectedCategory == category;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: GestureDetector(
                onTap: () => viewModel.updateCategory(category),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.blue2 : Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getCategoryIcon(category),
                        size: 18.sp,
                        color: isSelected ? Colors.white : AppColors.black,
                      ),
                      SizedBox(width: 6.w),
                      Flexible(
                        child: Text(
                          category.displayName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: FontSizes.f12,
                            fontWeight: FontWeight.w400,
                            color: isSelected ? Colors.white : AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getCategoryIcon(VisaCategory category) {
    switch (category) {
      case VisaCategory.travel:
        return Icons.flight_takeoff;
      case VisaCategory.student:
        return Icons.school;
      case VisaCategory.work:
        return Icons.work_outline;
      case VisaCategory.investment:
        return Icons.account_balance_wallet_outlined;
    }
  }
}
