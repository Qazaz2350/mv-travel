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
                                                    'assets/home/profile.avif',
                                                  )
                                                  as ImageProvider),
                                  child: viewModel.isLoading
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
                                      Nav.push(
                                        context,
                                        ChangeNotifierProvider.value(
                                          value: viewModel,
                                          child: const ProfilePictureEditPage(),
                                        ),
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
                                        size: 18.r,
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

                    // Communication Preferences
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19.r),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          // _buildSectionHeader('Communication Preferences'),
                          _buildInfoTileIfAvailable(
                            icon: Icons.email_outlined,
                            title: 'Email Notification',
                            subtitle: viewModel.emailNotification
                                ? "Enabled"
                                : null,
                          ),
                          _buildInfoTileIfAvailable(
                            icon: Icons.sms_outlined,
                            title: 'SMS Alerts',
                            subtitle: viewModel.smsAlerts ? "Enabled" : null,
                          ),
                          _buildInfoTileIfAvailable(
                            icon: Icons.chat_bubble_outline,
                            title: 'WhatsApp Update',
                            subtitle: viewModel.whatsappUpdate
                                ? "Enabled"
                                : null,
                          ),

                          // SizedBox(height: 24.h),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),
                    Center(
                      child: SizedBox(
                        width: 300.w,
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.logout(context);
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
