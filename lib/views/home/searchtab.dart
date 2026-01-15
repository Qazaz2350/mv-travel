import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/views/destination_view.dart';
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
              child: GestureDetector(
                onTap: () {
                  // Tapping the search container
                  Nav.push(context, DestinationView());
                },
                child: AbsorbPointer(
                  // Makes the TextField non-editable but still visible
                  child: TextField(
                    controller: viewModel.searchController,
                    readOnly: true, // important so keyboard doesn't show
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
                          AssetImage('assets/home/searchhome.png'),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
