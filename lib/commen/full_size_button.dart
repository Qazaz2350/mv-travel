import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';

class FRectangleButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final OutlinedBorder? shape; // optional shape

  const FRectangleButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.shape, // optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 12.h), // responsive height
        minimumSize: Size(double.infinity, 45.h), // responsive height
        shape:
            shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r), // default radius
            ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: FontSizes.f14, // your font system
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
