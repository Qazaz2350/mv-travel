// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/model/home_page_model.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/views/home/Action_Buttons_Widget.dart';
import 'package:mvtravel/views/home/active_application_widget.dart';
import 'package:mvtravel/views/home/featured_destinations_widget.dart';
// import 'package:mvtravel/views/home/featured_destinations_widget.dart';

class HomeTabbar extends StatefulWidget {
  final HomePageViewModel viewModel;
  const HomeTabbar({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<HomeTabbar> createState() => _HomeTabbarState();
}

class _HomeTabbarState extends State<HomeTabbar> {
  // late HomePageViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: VisaCategory.values.length,
      child: Column(
        children: [
          // TabBar mimicking original UI
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              height: 40.h, // same as original container height
              child: TabBar(
                dividerColor: Colors.transparent,
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                indicator: BoxDecoration(
                  color: AppColors.blue2,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                labelColor: Colors.white,
                labelPadding: EdgeInsets.symmetric(horizontal: 5.w),

                unselectedLabelColor: AppColors.black,
                tabs: VisaCategory.values.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_getCategoryIcon(category), size: 18.sp),
                          SizedBox(width: 6.w),
                          Flexible(
                            child: Text(
                              category.displayName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: FontSizes.f12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          SizedBox(height: 14.h),
          SizedBox(
            height: 700.h, // fixed height, adjust as needed
            child: TabBarView(
              children: [
                Column(
                  children: [
                    FeaturedDestinationsWidget(
                      destinations:
                          widget.viewModel.homeData.featuredDestinations,
                    ),
                    SizedBox(height: 15.h),
                    GestureDetector(
                      onTap: () {},

                      child: ActiveApplicationWidget(
                        viewModel: widget.viewModel,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ActionButtonsWidget(viewModel: widget.viewModel),
                    SizedBox(height: 40.h),
                  ],
                ),

                // SizedBox(height: 10.h),
                Center(
                  child: Text(
                    'Student',
                    style: TextStyle(fontSize: FontSizes.f14),
                  ),
                ),
                Center(
                  child: Text(
                    'Work',
                    style: TextStyle(fontSize: FontSizes.f14),
                  ),
                ),
                Center(
                  child: Text(
                    'Investment',
                    style: TextStyle(fontSize: FontSizes.f14),
                  ),
                ),
              ],
            ),
          ),
        ],
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
