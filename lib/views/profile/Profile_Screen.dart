import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/profile_image_viewmodel.dart';
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
    // Initialize ViewModel and fetch user profile once
    _viewModel = UserProfileViewModel();
    _viewModel.fetchUserProfile();
  }

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
              actions: [
                IconButton(
                  icon: Icon(Icons.edit_outlined, color: AppColors.black),
                  onPressed: () {
                    Nav.push(
                      context,
                      ChangeNotifierProvider.value(
                        value: viewModel, // pass the same UserProfileViewModel
                        child: const ProfilePictureEditPage(),
                      ),
                    );
                  },
                ),
              ],
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
                            Consumer<UserProfileViewModel>(
                              builder: (context, viewModel, child) {
                                return CircleAvatar(
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
                                );
                              },
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
                          _buildInfoTile(
                            icon: Icons.cake_outlined,
                            title: 'Birth Date',
                            subtitle: viewModel.birthDate,
                            onTap: () {},
                          ),
                          _buildInfoTile(
                            icon: Icons.description_outlined,
                            title: 'Passport Number',
                            subtitle: viewModel.passportNumber,
                            onTap: () {},
                          ),
                          _buildInfoTile(
                            icon: Icons.public,
                            title: 'Nationality',
                            subtitle: viewModel.nationality,
                            onTap: () {},
                          ),
                          _buildInfoTile(
                            icon: Icons.phone_outlined,
                            title: 'Phone Number',
                            subtitle: viewModel.phoneNumber,
                            onTap: () {},
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
                          _buildInfoTile(
                            icon: Icons.flight_takeoff,
                            title: 'Purpose of Travel',
                            subtitle: viewModel.purposeOfTravel,
                            onTap: () {},
                          ),
                          _buildInfoTile(
                            icon: Icons.credit_card,
                            title: 'Visa Type',
                            subtitle: viewModel.visaType,
                            onTap: () {},
                          ),
                          _buildInfoTile(
                            icon: Icons.calendar_today_outlined,
                            title: 'Travel Dates',
                            subtitle: viewModel.travelDates,
                            onTap: () {},
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
                          _buildSectionHeader('Uploaded Documents'),
                          _buildInfoTile(
                            icon: Icons.calendar_today_outlined,
                            title: 'Offer Letter',
                            subtitle: viewModel.offerLetterFileName,
                            onTap: () {
                              if (viewModel.offerLetterUrl != "Pending" &&
                                  viewModel.offerLetterUrl.isNotEmpty) {
                                // launch URL code here
                              }
                            },
                          ),
                          // Investment documents can be uncommented if needed
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
                          _buildSectionHeader('Communication Preferences'),
                          _buildInfoTile(
                            icon: Icons.email_outlined,
                            title: 'Email Notification',
                            subtitle: viewModel.emailNotification
                                ? "Enabled"
                                : "Pending",
                            onTap: () {},
                          ),
                          _buildInfoTile(
                            icon: Icons.sms_outlined,
                            title: 'SMS Alerts',
                            subtitle: viewModel.smsAlerts
                                ? "Enabled"
                                : "Pending",
                            onTap: () {},
                          ),
                          _buildInfoTile(
                            icon: Icons.chat_bubble_outline,
                            title: 'WhatsApp Update',
                            subtitle: viewModel.whatsappUpdate
                                ? "Enabled"
                                : "Pending",
                            onTap: () {},
                          ),
                          SizedBox(height: 24.h),
                          SizedBox(
                            width: 300.w, // Full width
                            child: ElevatedButton(
                              onPressed: () {
                                viewModel.logout(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.red, // Button background
                                foregroundColor: AppColors.white, // Text color
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                ), // Height of button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12.r,
                                  ), // Rounded corners
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

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),
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

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    // Set Pending = orange, all other data = green
    Color getSubtitleColor(String text) {
      if (text.toLowerCase() == "pending") return Colors.orange;
      return Colors.green;
    }

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
                    if (subtitle != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: FontSizes.f12,
                          color: getSubtitleColor(subtitle),
                        ),
                      ),
                    ],
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
