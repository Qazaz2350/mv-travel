import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/views/visa_detail_screen/visa_detail_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({super.key});

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  // Filter states
  String selectedEntryType = 'All';
  double maxPrice = 100000;
  int selectedDocCount = 0;
  String selectedStayDuration = 'All';

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
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                "Explore",
                                style: TextStyle(
                                  fontSize: FontSizes.f28,
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
                              vertical: 14.h,
                              horizontal: 20.w,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Filters Section
                    Container(
                      height: 70.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        children: [
                          // Entry Type Filter
                          _buildFilterChip(
                            // icon: Icons.login_rounded,
                            label: 'Entry',
                            value: selectedEntryType,
                            onTap: () => _showEntryTypeDialog(context),
                          ),
                          SizedBox(width: 12.w),

                          // Price Filter
                          _buildFilterChip(
                            // icon: Icons.payments_outlined,
                            label: 'Price',
                            value: maxPrice == 100000
                                ? 'Any'
                                : '≤ ${(maxPrice / 1000).toStringAsFixed(0)}k',
                            onTap: () => _showPriceDialog(context),
                          ),
                          SizedBox(width: 12.w),

                          // Documents Filter
                          _buildFilterChip(
                            // icon: Icons.description_outlined,
                            label: 'Documents',
                            value: selectedDocCount == 0
                                ? 'Any'
                                : '≤ $selectedDocCount docs',
                            onTap: () => _showDocumentsDialog(context),
                          ),
                          SizedBox(width: 12.w),

                          // Stay Duration Filter
                          _buildFilterChip(
                            // icon: Icons.calendar_today_outlined,
                            label: 'Stay',
                            value: selectedStayDuration,
                            onTap: () => _showStayDurationDialog(context),
                          ),
                          SizedBox(width: 12.w),

                          // Clear All Filters
                          if (_hasActiveFilters()) _buildClearFiltersButton(),
                        ],
                      ),
                    ),

                    SizedBox(height: 8.h),

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
                            : _buildFilteredList(vm),
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

  Widget _buildFilterChip({
    // required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    bool isActive =
        (label == 'Entry' && value != 'All') ||
        (label == 'Price' && value != 'Any') ||
        (label == 'Documents' && value != 'Any') ||
        (label == 'Stay' && value != 'All');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [AppColors.blue1, AppColors.blue2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isActive ? null : AppColors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isActive
                ? AppColors.white.withOpacity(0.4)
                : AppColors.white.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.blue1.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(icon, color: AppColors.white, size: 24.sp),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: FontSizes.f12,
                color: AppColors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: FontSizes.f14,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClearFiltersButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEntryType = 'All';
          maxPrice = 100000;
          selectedDocCount = 0;
          selectedStayDuration = 'All';
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.blue2.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.clear_all_rounded, color: AppColors.blue2, size: 24.sp),
            SizedBox(height: 8.h),
            Text(
              "Clear",
              style: TextStyle(
                fontSize: FontSizes.f14,
                color: AppColors.blue2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasActiveFilters() {
    return selectedEntryType != 'All' ||
        maxPrice != 100000 ||
        selectedDocCount != 0 ||
        selectedStayDuration != 'All';
  }

  Widget _buildFilteredList(HomePageViewModel vm) {
    var filtered = vm.filteredDestinations.where((destination) {
      // Entry type filter
      if (selectedEntryType != 'All') {
        if (destination.entry == null ||
            !destination.entry!.contains(selectedEntryType)) {
          return false;
        }
      }

      // Price filter
      if (destination.price != null && destination.price! > maxPrice) {
        return false;
      }

      // Documents filter
      if (selectedDocCount > 0) {
        if (destination.documents == null ||
            destination.documents!.length > selectedDocCount) {
          return false;
        }
      }

      // Stay duration filter
      if (selectedStayDuration != 'All') {
        if (destination.lengthOfStay == null) return false;

        int days =
            int.tryParse(destination.lengthOfStay!.split(' ').first) ?? 0;
        switch (selectedStayDuration) {
          case '≤ 30 Days':
            if (days > 30) return false;
            break;
          case '31-60 Days':
            if (days <= 30 || days > 60) return false;
            break;
          case '61-90 Days':
            if (days <= 60 || days > 90) return false;
            break;
          case '> 90 Days':
            if (days <= 90) return false;
            break;
        }
      }

      return true;
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.travel_explore_outlined,
              size: 0.sp,
              color: AppColors.grey1,
            ),
            SizedBox(height: 16.h),
            Text(
              "No destinations found",
              style: TextStyle(
                fontSize: FontSizes.f16,
                fontWeight: FontWeight.w600,
                color: AppColors.blue3,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Try adjusting your filters",
              style: TextStyle(fontSize: FontSizes.f14, color: AppColors.grey2),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final destination = filtered[index];

        return TweenAnimationBuilder(
          duration: Duration(milliseconds: 300 + (index * 100)),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double value, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue2.withOpacity(0.08),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VisaDetailScreen(destination: destination),
                      ),
                    );
                  },
                  splashColor: AppColors.blue.withOpacity(0.3),
                  highlightColor: AppColors.blue.withOpacity(0.1),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        // Country Flag with Gradient Border
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [AppColors.blue1, AppColors.blue2],
                            ),
                          ),
                          padding: EdgeInsets.all(3.w),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            padding: EdgeInsets.all(2.w),
                            child: CircleAvatar(
                              radius: 30.r,
                              backgroundImage: AssetImage(destination.imageUrl),
                              backgroundColor: AppColors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),

                        // Country Name
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                destination.country,
                                style: TextStyle(
                                  fontSize: FontSizes.f20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blue3,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Tap to explore",
                                style: TextStyle(
                                  fontSize: FontSizes.f14,
                                  color: AppColors.grey2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Arrow with Gradient Background
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.blue1, AppColors.blue2],
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blue1.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
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
    );
  }

  void _showEntryTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.blue2.withOpacity(0.1),
                  AppColors.blue3.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.blue1, AppColors.blue2],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.login_rounded,
                        color: AppColors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Entry Type",
                      style: TextStyle(
                        fontSize: FontSizes.f20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildDialogOption(context, 'All', selectedEntryType, (value) {
                  setState(() => selectedEntryType = value);
                }),
                _buildDialogOption(context, 'Single', selectedEntryType, (
                  value,
                ) {
                  setState(() => selectedEntryType = value);
                }),
                _buildDialogOption(context, 'Multiple', selectedEntryType, (
                  value,
                ) {
                  setState(() => selectedEntryType = value);
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPriceDialog(BuildContext context) {
    double tempPrice = maxPrice;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.blue2.withOpacity(0.1),
                      AppColors.blue3.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.blue1, AppColors.blue2],
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.payments_outlined,
                            color: AppColors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          "Maximum Price",
                          style: TextStyle(
                            fontSize: FontSizes.f20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blue3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Center(
                      child: Text(
                        tempPrice == 100000
                            ? "Any Price"
                            : "PKR ${tempPrice.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: FontSizes.f28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue2,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 6.h,
                        activeTrackColor: AppColors.blue2,
                        inactiveTrackColor: AppColors.grey1,
                        thumbColor: AppColors.blue1,
                        overlayColor: AppColors.blue1.withOpacity(0.2),
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 12.r,
                        ),
                      ),
                      child: Slider(
                        value: tempPrice,
                        min: 10000,
                        max: 100000,
                        divisions: 18,
                        onChanged: (value) {
                          setDialogState(() => tempPrice = value);
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: AppColors.grey2,
                                fontSize: FontSizes.f16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() => maxPrice = tempPrice);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              backgroundColor: AppColors.blue2,
                            ),
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: FontSizes.f16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDocumentsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.blue2.withOpacity(0.1),
                  AppColors.blue3.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.blue1, AppColors.blue2],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        color: AppColors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Documents Required",
                      style: TextStyle(
                        fontSize: FontSizes.f20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildDialogOption(
                  context,
                  'Any',
                  selectedDocCount.toString(),
                  (value) {
                    setState(() => selectedDocCount = 0);
                  },
                ),
                _buildDialogOption(
                  context,
                  '≤ 2 documents',
                  selectedDocCount.toString(),
                  (value) {
                    setState(() => selectedDocCount = 2);
                  },
                ),
                _buildDialogOption(
                  context,
                  '≤ 3 documents',
                  selectedDocCount.toString(),
                  (value) {
                    setState(() => selectedDocCount = 3);
                  },
                ),
                _buildDialogOption(
                  context,
                  '≤ 5 documents',
                  selectedDocCount.toString(),
                  (value) {
                    setState(() => selectedDocCount = 5);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showStayDurationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.blue2.withOpacity(0.1),
                  AppColors.blue3.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.blue1, AppColors.blue2],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Length of Stay",
                      style: TextStyle(
                        fontSize: FontSizes.f20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildDialogOption(context, 'All', selectedStayDuration, (
                  value,
                ) {
                  setState(() => selectedStayDuration = value);
                }),
                _buildDialogOption(context, '≤ 30 Days', selectedStayDuration, (
                  value,
                ) {
                  setState(() => selectedStayDuration = value);
                }),
                _buildDialogOption(
                  context,
                  '31-60 Days',
                  selectedStayDuration,
                  (value) {
                    setState(() => selectedStayDuration = value);
                  },
                ),
                _buildDialogOption(
                  context,
                  '61-90 Days',
                  selectedStayDuration,
                  (value) {
                    setState(() => selectedStayDuration = value);
                  },
                ),
                _buildDialogOption(context, '> 90 Days', selectedStayDuration, (
                  value,
                ) {
                  setState(() => selectedStayDuration = value);
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogOption(
    BuildContext context,
    String label,
    String currentValue,
    Function(String) onSelect,
  ) {
    bool isSelected =
        (label == currentValue) ||
        (label == 'Any' && currentValue == '0') ||
        (label == '≤ 2 documents' && currentValue == '2') ||
        (label == '≤ 3 documents' && currentValue == '3') ||
        (label == '≤ 5 documents' && currentValue == '5');

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(colors: [AppColors.blue1, AppColors.blue2])
            : null,
        color: isSelected ? null : AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : AppColors.grey1.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onSelect(label);
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: FontSizes.f16,
                      color: isSelected ? AppColors.white : AppColors.blue3,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: AppColors.white, size: 24.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
