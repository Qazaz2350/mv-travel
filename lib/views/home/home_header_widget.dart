import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/view_model/profile_viewmodel.dart';
import 'package:mvtravel/views/home/documents.dart';
import 'package:mvtravel/views/profile/Profile_Screen.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  final HomePageViewModel viewModel;

  const HeaderWidget({super.key, required this.viewModel});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late UserProfileViewModel profileVM;

  @override
  void initState() {
    super.initState();
    profileVM = UserProfileViewModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileVM.fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfileViewModel>.value(
      value: profileVM,
      child: Consumer<UserProfileViewModel>(
        builder: (context, vm, _) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                SizedBox(
                  width: 46.w,
                  height: 46.h,
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    child: GestureDetector(
                      onTap: () {
                        Nav.push(context, ProfileScreen());
                      },
                      child: ClipOval(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: Icon(
                              Icons.menu,
                              size: 28,
                              color: AppColors.black, // change color if needed
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Hi ${widget.viewModel.homeData.user.name}!',
                  style: TextStyle(
                    fontSize: FontSizes.f20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => Nav.push(context, DocumentsScreen()),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
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
        },
      ),
    );
  }
}
