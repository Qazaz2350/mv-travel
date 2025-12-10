import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/widgets/home_widgets/ApplicationCard_Widget.dart';

class ActiveApplicationWidget extends StatelessWidget {
  final HomePageViewModel viewModel;

  const ActiveApplicationWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Application',
                style: TextStyle(
                  fontSize: FontSizes.f20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              GestureDetector(
                onTap: viewModel.viewAllApplications,
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: FontSizes.f14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          ...viewModel.homeData.activeApplications
              .map((app) => ApplicationCardWidget(application: app))
              .toList(),
        ],
      ),
    );
  }
}
