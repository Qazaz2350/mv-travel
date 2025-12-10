import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';

class HeaderWidget extends StatelessWidget {
  final HomePageViewModel viewModel;

  const HeaderWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: CircleAvatar(
              backgroundColor: AppColors.grey,
              child: ClipOval(
                child: Image.asset(
                  "assets/home/profile.avif",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          Text(
            'Hi ${viewModel.homeData.user.name}!',
            style: TextStyle(
              fontSize: FontSizes.f20,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),

          Spacer(),

          GestureDetector(
            onTap: viewModel.openDocuments,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              child: Row(
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    size: 18.sp,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Documents',
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
