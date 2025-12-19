import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/view_model/profile_image_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class ProfilePictureEditPage extends StatelessWidget {
  const ProfilePictureEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.blue3, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile Picture',
          style: TextStyle(
            color: AppColors.blue3,
            fontSize: FontSizes.f20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ProfileImageViewModel>(
        builder: (context, vm, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.h),
                _buildProfilePicture(context, vm),
                SizedBox(height: 30.h),
                _buildActionButtons(context, vm),
                SizedBox(height: 40.h),
                _buildInfoCard(),
                SizedBox(height: 30.h),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<ProfileImageViewModel>(
        builder: (context, vm, child) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: vm.profileImage != null
                    ? () => _saveProfilePicture(context)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue3,
                  disabledBackgroundColor: AppColors.grey1,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Save Profile Picture',
                  style: TextStyle(
                    fontSize: FontSizes.f16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfilePicture(BuildContext context, ProfileImageViewModel vm) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 200.w,
            height: 200.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.blue1, AppColors.blue3],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue3.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipOval(
              child: vm.profileImage != null
                  ? Image.file(vm.profileImage!, fit: BoxFit.cover)
                  : Container(
                      color: AppColors.blue,
                      child: Icon(
                        Icons.person,
                        size: 80.sp,
                        color: AppColors.blue3,
                      ),
                    ),
            ),
          ),
          Positioned(
            bottom: 5.h,
            right: 5.w,
            child: GestureDetector(
              onTap: () => vm.pickImageFromGallery(),
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.blue3,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blue3.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: AppColors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ProfileImageViewModel vm) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          _buildActionButton(
            context,
            icon: Icons.photo_library_rounded,
            title: 'Choose from Gallery',
            subtitle: 'Select a photo from your device',
            onTap: () => vm.pickImageFromGallery(),
            gradient: LinearGradient(
              colors: [AppColors.blue1, AppColors.blue3],
            ),
          ),
          SizedBox(height: 16.h),
          if (vm.profileImage != null)
            _buildActionButton(
              context,
              icon: Icons.delete_outline_rounded,
              title: 'Remove Photo',
              subtitle: 'Delete current profile picture',
              onTap: () => _showRemoveDialog(context, vm),
              gradient: LinearGradient(
                colors: [Colors.red.shade400, Colors.red.shade600],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Gradient gradient,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: AppColors.white, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.blue3,
                      fontSize: FontSizes.f16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.grey2,
                      fontSize: FontSizes.f14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.grey1, size: 18.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.blue.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.info_outline,
              color: AppColors.blue3,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'pending',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: FontSizes.f16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'image upload nhi ho sakhti firestore pending hy',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: FontSizes.f14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, ProfileImageViewModel vm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Remove Photo?',
          style: TextStyle(
            color: AppColors.blue3,
            fontSize: FontSizes.f20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to remove your profile picture?',
          style: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              vm.removeImage();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text('Remove', style: TextStyle(fontSize: FontSizes.f14)),
          ),
        ],
      ),
    );
  }

  void _saveProfilePicture(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile picture saved successfully!'),
        backgroundColor: AppColors.green2,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
    Navigator.pop(context);
  }
}
