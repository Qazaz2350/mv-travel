import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  // Optional icon
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;

  // Optional image icon
  final ImageProvider? imageIcon;
  final Color? imageIconColor; // new color for image icon
  final double? imageIconSize;

  const ActionButton({
    Key? key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.imageIcon,
    this.imageIconColor,
    this.imageIconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // If IconData is provided
          if (icon != null) ...[
            Icon(icon, color: iconColor ?? textColor, size: iconSize ?? 20.sp),
            SizedBox(width: 8.w),
          ],

          // If ImageIcon is provided
          if (imageIcon != null) ...[
            ImageIcon(
              imageIcon!,
              color: imageIconColor ?? textColor,
              size: imageIconSize ?? 20.sp,
            ),
            SizedBox(width: 8.w),
          ],

          // Text always present
          Text(
            text,
            style: TextStyle(
              fontSize: FontSizes.f14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
