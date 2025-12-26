// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mvtravel/utilis/FontSizes.dart';
// import 'package:mvtravel/utilis/colors.dart';

// class AppDateField extends StatelessWidget {
//   final String label;
//   final String hint;
//   final TextEditingController controller;
//   final VoidCallback onTap;

//   const AppDateField({
//     super.key,
//     required this.label,
//     required this.hint,
//     required this.controller,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: FontSizes.f14,
//             fontWeight: FontWeight.w600,
//             color: AppColors.black,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         TextField(
//           controller: controller,
//           readOnly: true,
//           onTap: onTap,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(
//               color: AppColors.grey2,
//               fontSize: FontSizes.f14,
//             ),
//             filled: true,
//             fillColor: AppColors.white,
//             prefixIcon: Icon(Icons.calendar_today, color: AppColors.grey2),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.r),
//               borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.r),
//               borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.r),
//               borderSide: BorderSide(color: AppColors.blue),
//             ),
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 16.w,
//               vertical: 14.h,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
