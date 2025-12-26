import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/profile_image_viewmodel.dart';
import 'package:mvtravel/view_model/profile_viewmodel.dart';
import 'package:mvtravel/views/profile/profile_edit_page.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
              actions: [
                IconButton(
                  icon: Icon(Icons.edit_outlined, color: AppColors.black),
                  onPressed: () {
                    Nav.push(
                      context,
                      ChangeNotifierProvider(
                        create: (_) => ProfileImageViewModel(),
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
                            CircleAvatar(
                              radius: 50.r,
                              backgroundImage: AssetImage(
                                'assets/home/profile.avif',
                              ),
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
                          ...viewModel.uploadedDocs.isNotEmpty
                              ? viewModel.uploadedDocs.map((doc) {
                                  return _buildInfoTile(
                                    icon: Icons.attach_file,
                                    title: doc.toString(),
                                    onTap: () {},
                                  );
                                }).toList()
                              : [
                                  _buildInfoTile(
                                    icon: Icons.attach_file,
                                    title: "Pending",
                                    onTap: () {},
                                  ),
                                ],
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
                          color: AppColors.grey2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Icon(Icons.chevron_right, color: AppColors.grey2, size: 24.sp),
            ],
          ),
        ),
      ),
    );
  }
}
