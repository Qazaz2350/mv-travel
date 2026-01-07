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
  final Color? imageIconColor;
  final double? imageIconSize;

  // Optional custom child (for loading spinner)
  final Widget? child;

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
    this.child,
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
      child:
          child ??
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: iconColor ?? textColor,
                  size: iconSize ?? 20.sp,
                ),
                SizedBox(width: 8.w),
              ],
              if (imageIcon != null) ...[
                ImageIcon(
                  imageIcon!,
                  color: imageIconColor ?? textColor,
                  size: imageIconSize ?? 20.sp,
                ),
                SizedBox(width: 8.w),
              ],
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
