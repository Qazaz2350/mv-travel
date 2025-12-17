import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class UploadCard extends StatelessWidget {
  final String title;
  final String description;
  final File? file;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onRemove;

  const UploadCard({
    super.key,
    required this.title,
    required this.description,
    required this.file,
    required this.onCamera,
    required this.onGallery,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(title),
          _desc(description),
          SizedBox(height: 16.h),
          file == null
              ? GestureDetector(
                  onTap: onGallery,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.grey2,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        ImageIcon(
                          AssetImage('assets/home/upload.png'),
                          size: 40,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Tap to Upload',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Supported: PDF, JPG',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey2,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : _filePreview(file!, onRemove),
        ],
      ),
    );
  }

  Widget _filePreview(File file, VoidCallback onRemove) {
    return Container(
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.file(file, fit: BoxFit.cover),
      ),
    );
  }

  Widget _card(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child,
    );
  }

  Widget _title(String text) => Text(
        text,
        style: TextStyle(
          fontSize: FontSizes.f20,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _desc(String text) => Text(
        text,
        style: TextStyle(
          fontSize: FontSizes.f14,
          color: AppColors.grey2,
        ),
      );
}
