import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class UploadFieldWidget extends StatelessWidget {
  final String label;
  final String acceptedFormats;
  final File? file;
  final String? fileName;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  // Optional camera/gallery callbacks
  final VoidCallback? onCamera;
  final VoidCallback? onGallery;

  const UploadFieldWidget({
    super.key,
    required this.label,
    required this.acceptedFormats,
    this.file,
    this.fileName,
    required this.onTap,
    required this.onRemove,
    this.onCamera,
    this.onGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: file != null ? AppColors.blue : AppColors.white,
            border: Border.all(
              color: file != null
                  ? (AppColors.blue)
                  // ignore: deprecated_member_use
                  : AppColors.grey2.withOpacity(0.3),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: file == null
              ? Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 40.sp,
                      color: AppColors.grey2,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Click to upload',
                      style: TextStyle(
                        fontSize: FontSizes.f14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      acceptedFormats,
                      style: TextStyle(
                        fontSize: FontSizes.f12,
                        color: AppColors.grey2,
                      ),
                    ),
                    if (onCamera != null && onGallery != null) ...[
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: onCamera,
                            icon: Icon(Icons.camera_alt, size: 18.sp),
                            label: Text('Camera'),
                          ),
                          SizedBox(width: 16.w),
                          ElevatedButton.icon(
                            onPressed: onGallery,
                            icon: Icon(Icons.photo_library, size: 18.sp),
                            label: Text('Gallery'),
                          ),
                        ],
                      ),
                    ],
                  ],
                )
              : Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.blue,
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fileName ?? 'File uploaded',
                            style: TextStyle(
                              fontSize: FontSizes.f14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Tap to change',
                            style: TextStyle(
                              fontSize: FontSizes.f12,
                              color: AppColors.grey2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: onRemove,
                    ),
                  ],
                ),
        ).gesture(onTap),
      ],
    );
  }
}

// Helper extension to add gesture only when onTap exists
extension on Widget {
  Widget gesture(VoidCallback? onTap) {
    return onTap != null ? GestureDetector(onTap: onTap, child: this) : this;
  }
}
