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
                        // viewModel: widget.viewModel,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ActionButtonsWidget(viewModel: widget.viewModel),
                    SizedBox(height: 40.h),
                  ],
                ),

                // SizedBox(height: 10.h),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(24),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Section
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.blue.shade600,
                                Colors.blue.shade400,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "Explore the World, One Trip at a Time",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              "Discover tourist destinations that turn learning into adventure. From historic landmarks to breathtaking natural views",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.6,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),

                          SizedBox(height: 12),

                          // Decorative Divider
                          Container(
                            width: 60,
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade200,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),

                          SizedBox(height: 12),

                          // Second Section
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.blue.shade600,
                                Colors.blue.shade400,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "Travel Smart, Travel Together",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              "Affordable, safe, and exciting trips designed especially for students. Enjoy guided tours",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.6,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FeaturedDestinationsWidget(
                      destinations:
                          widget.viewModel.homeData.featuredDestinations,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Section
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.blue.shade600,
                                Colors.blue.shade400,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "Build Your Career, One Opportunity at a Time",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              "Explore work opportunities that shape your future. From entry-level roles to international placements, start your professional journey with confidence.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.6,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),

                          SizedBox(height: 12),

                          // Decorative Divider
                          Container(
                            width: 60,
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade200,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),

                          SizedBox(height: 12),

                          // Second Section
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.blue.shade600,
                                Colors.blue.shade400,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "Work Smart, Grow Together",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              "Reliable, skill-focused, and career-driven work options designed to help you gain experience, earn confidently, and grow professionally.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.6,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FeaturedDestinationsWidget(
                      destinations:
                          widget.viewModel.homeData.featuredDestinations,
                    ),
                  ],
                ),

                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Section
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.blue.shade600,
                                Colors.blue.shade400,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "Invest Smart, Build a Secure Future",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              "Discover investment opportunities designed to grow your wealth. From low-risk plans to long-term strategies, make informed financial decisions with confidence.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.6,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),

                          SizedBox(height: 12),

                          // Decorative Divider
                          Container(
                            width: 60,
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade200,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),

                          SizedBox(height: 12),

                          // Second Section
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.blue.shade600,
                                Colors.blue.shade400,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              "Grow Together with Trusted Investments",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              "Secure, transparent, and goal-oriented investment options that help you plan ahead, protect your capital, and achieve financial growth over time.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.6,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FeaturedDestinationsWidget(
                      destinations:
                          widget.viewModel.homeData.featuredDestinations,
                    ),
                  ],
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
