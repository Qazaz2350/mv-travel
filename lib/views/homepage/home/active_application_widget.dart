import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/onboarding/application_view_model.dart';
import 'package:mvtravel/view_model/onboarding/home_page_viewmodel.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/views/homepage/visa_detail_screen/visa_detail_view.dart';
import 'package:mvtravel/views/homepage/home/ApplicationCard_Widget.dart';

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
              Text(
                'See all',
                style: TextStyle(
                  fontSize: FontSizes.f14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blue1,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // ...viewModel.homeData.activeApplications
          //     .map((app) => ApplicationCardWidget(application: app))
          //     .toList(),
          ApplicationCardWidget(viewModel: ApplicationViewModel()),
        ],
      ),
    );
  }
}
