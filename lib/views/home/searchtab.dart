import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/views/filter.dart/FiltersDialog.dart';

class SearchBarWidget extends StatelessWidget {
  final HomePageViewModel viewModel;

  const SearchBarWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: AppColors.grey1.withOpacity(0.5),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: viewModel.searchController,
                style: TextStyle(
                  fontSize: FontSizes.f14,
                  color: AppColors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter Destination',
                  hintStyle: TextStyle(
                    fontSize: FontSizes.f14,
                    color: AppColors.grey2,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 12.w),
                    child: ImageIcon(
                      AssetImage('assets/home/search.png'),
                      size: 20,
                      color: Color(0xff5C5C5C),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 0,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 6.h),
              width: 60.w, // make width equal to height
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.blue1,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center, // center the icon
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => FiltersDialog(),
                  );
                },
                child: ImageIcon(
                  AssetImage('assets/home/settings.png'),
                  size: 20,
                  color: Colors.white,
                ),
              ),
              // child: Icon(Icons.tune, color: Colors.white, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
