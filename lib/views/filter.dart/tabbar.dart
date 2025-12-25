import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/views/filter.dart/work_tabbar_view.dart';

class FilterTabsScreen extends StatefulWidget {
  const FilterTabsScreen({super.key});

  @override
  State<FilterTabsScreen> createState() => _FilterTabsScreenState();
}

class _FilterTabsScreenState extends State<FilterTabsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ['Travel', 'Student', 'Work', 'Investment'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // updates selected UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// TAB BAR (UI SAME AS YOUR CONTAINER)
        TabBar(
          labelPadding: EdgeInsets.all(7.w),

          tabAlignment: TabAlignment.center,
          controller: _tabController,
          isScrollable: true,

          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          tabs: List.generate(tabs.length, (index) {
            final bool isSelected = _tabController.index == index;

            return Tab(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blue1 : AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.black,
                    fontSize: FontSizes.f14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ),

        SizedBox(height: 16.h),

        /// TAB BAR VIEW
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              Center(child: Text('Travel Content')),
              Center(child: Text('Student Content')),
              Center(child: JobFiltersScreen()),
              Center(child: Text('Investment Content')),
            ],
          ),
        ),
      ],
    );
  }
}
