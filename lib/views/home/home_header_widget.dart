import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/views/home/documents.dart';
import 'package:mvtravel/views/profile/Profile_Screen.dart';

class HeaderWidget extends StatefulWidget {
  final HomePageViewModel viewModel;

  const HeaderWidget({super.key, required this.viewModel});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 46.w,
            height: 46.h,
            child: GestureDetector(
              onTap: () => Nav.push(context, ProfileScreen()),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[200],
                backgroundImage: widget.viewModel.profileImageUrl != null
                    ? NetworkImage(widget.viewModel.profileImageUrl!)
                    : null,
                child: widget.viewModel.profileImageUrl == null
                    ? Icon(Icons.person, size: 40, color: Colors.grey)
                    : null,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // ---------------- Greeting Text ----------------
          Text(
            'Hi ${widget.viewModel.profileFullName}!',
            style: TextStyle(
              fontSize: FontSizes.f20,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          Spacer(),

          // ---------------- Documents Button ----------------
          GestureDetector(
            onTap: () => Nav.push(context, DocumentsScreen()),
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
