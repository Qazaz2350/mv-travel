import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/profile_viewmodel.dart';
import 'package:mvtravel/views/profile/profile_edit_page.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = UserProfileViewModel();
    _viewModel.fetchUserProfile();
  }

  void _showPhotoOptionsBottomSheet(
    BuildContext context,
    UserProfileViewModel viewModel,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.grey2.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Profile Photo',
                style: TextStyle(
                  fontSize: FontSizes.f16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 10.h),
              _buildBottomSheetOption(
                context: context,
                icon: Icons.photo_camera,
                title: 'Upload Photo',
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickAndUploadProfileImage();
                },
              ),
              Divider(height: 1, color: AppColors.grey.withOpacity(0.5)),
              _buildBottomSheetOption(
                context: context,
                icon: Icons.delete_outline,
                title: 'Remove Photo',
                titleColor: Colors.red,
                iconColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  viewModel.removeProfileImage();
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? titleColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.blue1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.blue1,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                fontSize: FontSizes.f16,
                fontWeight: FontWeight.w500,
                color: titleColor ?? AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProfileViewModel()..fetchUserProfile(),
      child: Consumer<UserProfileViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Scaffold(
              backgroundColor: AppColors.grey,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.blue1),
              ),
            );
          }

          return Scaffold(
            backgroundColor: AppColors.grey,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              surfaceTintColor: Colors.white,
              scrolledUnderElevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.black),
                onPressed: () => Nav.pop(context),
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: FontSizes.f20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    // Profile Header
                    Center(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19.r),
                          color: AppColors.white,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 22.h),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50.r,
                                  backgroundImage:
                                      viewModel.profileImageFile != null
                                      ? FileImage(viewModel.profileImageFile!)
                                      : (viewModel.profileImageUrl != null
                                            ? NetworkImage(
                                                viewModel.profileImageUrl!,
                                              )
                                            : const AssetImage(
                                                    'assets/home/user.png',
                                                  )
                                                  as ImageProvider),
                                  child: viewModel.isUploading
                                      ? SizedBox(
                                          width: 30.r,
                                          height: 30.r,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showPhotoOptionsBottomSheet(
                                        context,
                                        viewModel,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.blue1,
                                      ),
                                      padding: EdgeInsets.all(6.r),
                                      child: Icon(
                                        Icons.edit,
                                        size: 14.r,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              viewModel.fullName,
                              style: TextStyle(
                                fontSize: FontSizes.f20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              viewModel.email,
                              style: TextStyle(
                                fontSize: FontSizes.f14,
                                color: AppColors.grey2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Personal Information
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19.r),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          _buildSectionHeader('Personal Information'),
                          _buildInfoTileIfAvailable(
                            icon: Icons.cake_outlined,
                            title: 'Birth Date',
                            subtitle: viewModel.birthDate,
                          ),
                          _buildInfoTileIfAvailable(
                            icon: Icons.public,
                            title: 'Residence',
                            subtitle: viewModel.residence,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19.r),
                              color: AppColors.white,
                            ),
                            child: Column(
                              children: [
                                // _buildSectionHeader('Investment Details'),
                                _buildInfoTileIfAvailable(
                                  icon: Icons.monetization_on_outlined,
                                  title: 'Investment Amount',
                                  subtitle: viewModel.investmentAmount,
                                ),
                                _buildInfoTileIfAvailable(
                                  icon: Icons.account_balance_wallet_outlined,
                                  title: 'Investment Type',
                                  subtitle: viewModel.investmentType,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19.r),
                              color: AppColors.white,
                            ),
                            child: Column(
                              children: [
                                // _buildSectionHeader('Work Application'),
                                _buildInfoTileIfAvailable(
                                  icon: Icons.work_outline,
                                  title: 'Job Title',
                                  subtitle: viewModel.jobTitle,
                                ),
                                _buildInfoTileIfAvailable(
                                  icon: Icons.timelapse_outlined,
                                  title: 'Experience',
                                  subtitle: viewModel.experience,
                                ),
                                _buildInfoTileIfAvailable(
                                  icon: Icons.attach_money_outlined,
                                  title: 'Salary',
                                  subtitle: viewModel.salary,
                                ),
                                if (viewModel.hasJobOffer)
                                  _buildInfoTileIfAvailable(
                                    icon: Icons.check_circle_outline,
                                    title: 'Job Offer',
                                    subtitle: "Yes",
                                  ),
                              ],
                            ),
                          ),

                          // _buildInfoTileIfAvailable(
                          //   icon: Icons.phone_outlined,
                          //   title: 'Phone Number',
                          //   subtitle: viewModel.phoneDialCode.isNotEmpty
                          //       ? "${viewModel.phoneDialCode} ${viewModel.phoneNumber}"
                          //       : viewModel.phoneNumber,
                          // ),
                          _buildInfoTileIfAvailable(
                            icon: Icons.public,
                            title: 'Nationality',
                            subtitle: viewModel.nationality,
                          ),
                          _buildInfoTileIfAvailable(
                            icon: Icons.phone_outlined,
                            title: 'Phone Number',
                            subtitle: viewModel.phoneNumber,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Travel Details
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19.r),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          _buildSectionHeader('Travel Details'),
                          _buildInfoTileIfAvailable(
                            icon: Icons.flight_takeoff,
                            title: 'Purpose of Travel',
                            subtitle: viewModel.purposeOfTravel,
                          ),
                          _buildInfoTileIfAvailable(
                            icon: Icons.credit_card,
                            title: 'Visa Type',
                            subtitle: viewModel.visaType,
                          ),
                          _buildInfoTileIfAvailable(
                            icon: Icons.calendar_today_outlined,
                            title: 'Travel Dates',
                            subtitle: viewModel.travelDates,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Uploaded Documents
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19.r),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          _buildInfoTileIfAvailable(
                            icon: Icons.calendar_today_outlined,
                            title: 'Offer Letter',
                            subtitle:
                                (viewModel.offerLetterUrl != "Pending" &&
                                    viewModel.offerLetterUrl.isNotEmpty)
                                ? viewModel.offerLetterFileName
                                : null,
                            onTap: () {
                              if (viewModel.offerLetterUrl != "Pending" &&
                                  viewModel.offerLetterUrl.isNotEmpty) {
                                // launch URL code here
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Center(
                      child: SizedBox(
                        width: 300.w,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  content: SizedBox(
                                    width: 420.w, // 👈 dialog width

                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Confirm Logout",
                                          style: TextStyle(
                                            fontSize: FontSizes.f16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        Text(
                                          "Are you sure you want to log out?",
                                          style: TextStyle(
                                            fontSize: FontSizes.f14,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  fontSize: FontSizes.f14,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                viewModel.logout(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                foregroundColor:
                                                    AppColors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.r,
                                                      ),
                                                ),
                                              ),
                                              child: Text(
                                                "Log out",
                                                style: TextStyle(
                                                  fontSize: FontSizes.f14,
                                                  fontWeight: FontWeight.w600,
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: AppColors.white,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: FontSizes.f16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        child: Text(
          title,
          style: TextStyle(
            fontSize: FontSizes.f16,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }

  /// Only builds tile if subtitle is not null or empty
  Widget _buildInfoTileIfAvailable({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    if (subtitle == null ||
        subtitle.toLowerCase() == "pending" ||
        subtitle.isEmpty) {
      return SizedBox.shrink();
    }

    return _buildInfoTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: onTap ?? () {},
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: AppColors.grey2, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: FontSizes.f14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: FontSizes.f12,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
