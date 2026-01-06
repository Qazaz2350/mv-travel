import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/colors.dart';

void showCustomSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  final snackBar = SnackBar(
    content: SizedBox(
      height: 30, // smaller height
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    ),
    backgroundColor: isError ? Colors.orange : AppColors.blue1,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.symmetric(horizontal: 16), // optional padding
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
