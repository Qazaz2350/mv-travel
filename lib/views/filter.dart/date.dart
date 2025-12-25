import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/FontSizes.dart';

class DateRangeSelector extends StatefulWidget {
  const DateRangeSelector({Key? key}) : super(key: key);

  @override
  State<DateRangeSelector> createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blue1, // header background
              onPrimary: AppColors.white, // header text color
              onSurface: AppColors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.blue1, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // From Date
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(fromController),
            child: AbsorbPointer(
              child: TextField(
                controller: fromController,
                decoration: InputDecoration(
                  labelText: "From",
                  labelStyle: TextStyle(fontSize: FontSizes.f14),
                  hintText: "Select start date",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColors.blue1),
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: AppColors.blue1,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        // To Date
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(toController),
            child: AbsorbPointer(
              child: TextField(
                controller: toController,
                decoration: InputDecoration(
                  labelText: "To",
                  labelStyle: TextStyle(fontSize: FontSizes.f14),
                  hintText: "Select end date",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColors.blue1),
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: AppColors.blue1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
