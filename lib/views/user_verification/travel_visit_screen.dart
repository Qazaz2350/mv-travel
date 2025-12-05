import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/commen/full_size_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/travel_visit_viewmodel.dart';
import 'package:provider/provider.dart';

class TravelVisaView extends StatelessWidget {
  const TravelVisaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TravelVisaViewModel(),
      child: const _TravelVisaContent(),
    );
  }
}

class _TravelVisaContent extends StatelessWidget {
  const _TravelVisaContent({Key? key}) : super(key: key);

  Future<void> _selectDate(
    BuildContext context,
    bool isStartDate,
    TravelVisaViewModel viewModel,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: ColorScheme.light(primary: AppColors.blue1)),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (isStartDate) {
        viewModel.setStartDate(picked);
      } else {
        viewModel.setEndDate(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TravelVisaViewModel>();

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 22.sp),
          onPressed: () => Nav.pop(context),
        ),
        title: Text(
          'Visit Application Details',
          style: TextStyle(
            color: AppColors.black,
            fontSize: FontSizes.f16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Travel Visa',
              style: TextStyle(
                fontSize: FontSizes.f20,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 24.h),

            // Start Date and End Date Row
            Row(
              children: [
                Expanded(
                  child: _DateField(
                    label: 'Start Date',
                    date: viewModel.model.startDate,
                    formattedDate: viewModel.formatDate(
                      viewModel.model.startDate,
                    ),
                    onTap: () => _selectDate(context, true, viewModel),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _DateField(
                    label: 'End Date',
                    date: viewModel.model.endDate,
                    formattedDate: viewModel.formatDate(
                      viewModel.model.endDate,
                    ),
                    onTap: () => _selectDate(context, false, viewModel),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Reason Field
            Text(
              'Reason',
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                onChanged: viewModel.setReason,
                maxLines: 3,
                style: TextStyle(fontSize: FontSizes.f14),
                decoration: InputDecoration(
                  hintText: 'Type Reasons',
                  hintStyle: TextStyle(
                    color: AppColors.grey2,
                    fontSize: FontSizes.f14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(16.w),
                  filled: true,
                  fillColor: AppColors.white,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Estimated Budget Field
            Text(
              'Estimated Budget for Trip (in USD)',
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                onChanged: viewModel.setEstimatedBudget,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: FontSizes.f14),
                decoration: InputDecoration(
                  hintText: '\$ e.g., 5000',
                  hintStyle: TextStyle(
                    color: AppColors.grey2,
                    fontSize: FontSizes.f14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(16.w),
                  filled: true,
                  fillColor: AppColors.white,
                ),
              ),
            ),
            SizedBox(height: 200.h),

            // Save Button
            FRectangleButton(
              text: 'Save',
              color: AppColors.blue3,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// WIDGET - _DateField
// ============================================
class _DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final String formattedDate;
  final VoidCallback onTap;

  const _DateField({
    Key? key,
    required this.label,
    required this.date,
    required this.formattedDate,
    required this.onTap,
  }) : super(key: key);

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
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18.sp,
                  color: AppColors.grey2,
                ),
                SizedBox(width: 8.w),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: FontSizes.f14,
                    color: date != null ? AppColors.black : AppColors.grey2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
