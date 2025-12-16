import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';

// Import your custom classes (adjust the paths as per your project structure)
// import 'package:mvtravel/utilis/AppColors.dart';
// import 'package:mvtravel/utilis/FontSizes.dart';
// import 'package:mvtravel/utilis/Nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.white, //
        scrolledUnderElevation: 0,
        // elevation: 0,
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
              // Handle edit action
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
                  // height: 200.h,
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
                        backgroundImage: AssetImage('assets/home/profile.avif'),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Elara Vance',
                        style: TextStyle(
                          fontSize: FontSizes.f20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'elara.vance@email.com',
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

              // Personal Information Section
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
                      subtitle: '04 November 2003',
                      onTap: () {},
                    ),
                    // _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.description_outlined,
                      title: 'Passport Number',
                      subtitle: 'P123456789',
                      onTap: () {},
                    ),
                    // _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.public,
                      title: 'Nationality',
                      subtitle: 'Pakistan',
                      onTap: () {},
                    ),
                    // _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.phone_outlined,
                      title: 'Phone Number',
                      subtitle: '92+ 123 456 789',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Travel Details Section
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
                      subtitle: 'Business',
                      onTap: () {},
                    ),
                    // _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.credit_card,
                      title: 'Visa Type',
                      subtitle: 'B-1 Business Visitor',
                      onTap: () {},
                    ),
                    // _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.calendar_today_outlined,
                      title: 'Travel Dates',
                      subtitle: 'Nov 26, 2025 - Dec 26, 2025',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Uploaded Documents Section
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.r),
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    _buildSectionHeader('Uploaded Documents'),
                    _buildInfoTile(
                      icon: Icons.attach_file,
                      title: 'Passport PDF',
                      onTap: () {},
                    ),
                    //  // _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.image_outlined,
                      title: 'Passport-Size photo',
                      onTap: () {},
                    ),
                    //  //  // _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.description_outlined,
                      title: 'National ID Card',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Communication Preferences Section
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
                      onTap: () {},
                    ),
                    //  //  // _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.sms_outlined,
                      title: 'SMS Alerts',
                      onTap: () {},
                    ),
                    //  // _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.chat_bubble_outline,
                      title: 'WhatsApp Update',
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        // color: Colors.black,
      ),
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
              Icon(Icons.chevron_right, color: AppColors.grey2, size: 24.sp),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildDivider() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 68.w),
  //     child: Divider(height: 1.h, thickness: 1.h, color: AppColors.grey),
  //   );
  // }
}
