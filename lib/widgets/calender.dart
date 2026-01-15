import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/colors.dart';

class AppDateField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color? primaryColor;

  const AppDateField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.onTap,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          style: TextStyle(
            fontSize:
                12.sp, // <-- sets font size of both normal and selected text
            color: Colors.black,
          ),
          controller: controller,
          readOnly: true,
          onTap:
              onTap ??
              () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: initialDate ?? DateTime(2000),
                  firstDate: firstDate ?? DateTime(1900),
                  lastDate: lastDate ?? DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary:
                              primaryColor ?? Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (pickedDate != null) {
                  controller.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.grey2),
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 12.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey1),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
