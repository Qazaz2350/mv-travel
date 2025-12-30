import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/views/visa_detail_screen/visa_detail_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import your color and font classes
// import 'package:mvtravel/utils/app_colors.dart';
// import 'package:mvtravel/utils/font_sizes.dart';

class DestinationView extends StatelessWidget {
  const DestinationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageViewModel(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.blue2, AppColors.blue3],
            ),
          ),
          child: SafeArea(
            child: Consumer<HomePageViewModel>(
              builder: (context, vm, _) {
                return Column(
                  children: [
                    // Header Section
                    Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: AppColors.white.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.explore_outlined,
                                  color: AppColors.white,
                                  size: 28.sp,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                "Explore",
                                style: TextStyle(
                                  fontSize: FontSizes.f40,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Discover your next adventure",
                            style: TextStyle(
                              fontSize: FontSizes.f16,
                              color: AppColors.white.withOpacity(0.95),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Search Bar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blue3.withOpacity(0.15),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: vm.searchController,
                          style: TextStyle(
                            fontSize: FontSizes.f16,
                            color: AppColors.blue3,
                          ),
                          decoration: InputDecoration(
                            hintText: "Search destinations...",
                            hintStyle: TextStyle(
                              color: AppColors.grey1,
                              fontSize: FontSizes.f16,
                            ),
                            prefixIcon: Container(
                              margin: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.search,
                                color: AppColors.blue3,
                                size: 20.sp,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18.h,
                              horizontal: 20.w,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Destination List
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                          ),
                        ),
                        child: vm.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.blue2,
                                  ),
                                  strokeWidth: 3,
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.only(
                                  top: 24.h,
                                  bottom: 24.h,
                                ),
                                itemCount: vm.filteredDestinations.length,
                                itemBuilder: (context, index) {
                                  final destination =
                                      vm.filteredDestinations[index];

                                  return TweenAnimationBuilder(
                                    duration: Duration(
                                      milliseconds: 300 + (index * 100),
                                    ),
                                    tween: Tween<double>(begin: 0, end: 1),
                                    builder: (context, double value, child) {
                                      return Transform.translate(
                                        offset: Offset(0, 50 * (1 - value)),
                                        child: Opacity(
                                          opacity: value,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 24.w,
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.blue2.withOpacity(
                                              0.08,
                                            ),
                                            blurRadius: 20,
                                            offset: Offset(0, 8),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              // Navigate to detail page with the selected destination
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      VisaDetailScreen(
                                                        destination:
                                                            destination,
                                                      ),
                                                ),
                                              );
                                            },
                                            splashColor: AppColors.blue
                                                .withOpacity(0.3),
                                            highlightColor: AppColors.blue
                                                .withOpacity(0.1),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.w),
                                              child: Row(
                                                children: [
                                                  // Country Flag with Gradient Border
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          AppColors.blue1,
                                                          AppColors.blue2,
                                                        ],
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.all(
                                                      3.w,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.white,
                                                      ),
                                                      padding: EdgeInsets.all(
                                                        2.w,
                                                      ),
                                                      child: CircleAvatar(
                                                        radius: 30.r,
                                                        backgroundImage:
                                                            AssetImage(
                                                              destination
                                                                  .imageUrl,
                                                            ),
                                                        backgroundColor:
                                                            AppColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 16.w),

                                                  // Country Name
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          destination.country,
                                                          style: TextStyle(
                                                            fontSize:
                                                                FontSizes.f20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                AppColors.blue3,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4.h),
                                                        Text(
                                                          "Tap to explore",
                                                          style: TextStyle(
                                                            fontSize:
                                                                FontSizes.f14,
                                                            color:
                                                                AppColors.grey2,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Arrow with Gradient Background
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                      10.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          AppColors.blue1,
                                                          AppColors.blue2,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12.r,
                                                          ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: AppColors.blue1
                                                              .withOpacity(0.3),
                                                          blurRadius: 8,
                                                          offset: Offset(0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 16.sp,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
