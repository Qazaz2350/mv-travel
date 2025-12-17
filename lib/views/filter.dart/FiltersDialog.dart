// lib/views/filters_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/half_button.dart';
// import 'package:mvtravel/model/home_page_model.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
// import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/filters_viewmodel.dart';
import 'package:mvtravel/views/filter.dart/country_picker.dart';
import 'package:mvtravel/views/filter.dart/date_field_widget.dart';
import 'package:mvtravel/views/filter.dart/region_picker.dart';
import 'package:mvtravel/views/filter.dart/select_tile.dart';
import 'package:mvtravel/views/filter.dart/status_chip.dart';
import 'package:mvtravel/views/filter.dart/tabbar.dart';
// import 'package:mvtravel/views/visa_application_screen/visa_application_view.dart';

// Make sure the import paths match your project structure.
// Previously this file contained both UI and state. Now UI uses the viewModel.

class FiltersDialog extends StatefulWidget {
  const FiltersDialog({Key? key}) : super(key: key);

  @override
  State<FiltersDialog> createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  late FiltersViewModel viewModel;
  late VoidCallback _vmListener;

  @override
  void initState() {
    super.initState();
    viewModel = FiltersViewModel();
    _vmListener = () => setState(() {});
    viewModel.addListener(_vmListener);
  }

  @override
  void dispose() {
    viewModel.removeListener(_vmListener);
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          (isFrom ? viewModel.fromDate : viewModel.toDate) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blue2,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isFrom) {
        viewModel.setFromDate(picked);
      } else {
        viewModel.setToDate(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(vertical: 24.h),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: 740.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: FontSizes.f20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.grey),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Visa Type Section
                    Text(
                      'Visa Type',
                      style: TextStyle(
                        fontSize: FontSizes.f16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        SizedBox(height: 18.w),
                        FilterTabbar(label: 'Travel', viewModel: viewModel),
                        SizedBox(width: 8.w),
                        FilterTabbar(label: 'Student', viewModel: viewModel),
                        SizedBox(width: 8.w),
                        FilterTabbar(label: 'Work', viewModel: viewModel),
                        SizedBox(width: 8.w),
                        FilterTabbar(label: 'Investment', viewModel: viewModel),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Destination Section
                    Text(
                      'Destination',
                      style: TextStyle(
                        fontSize: FontSizes.f16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SelectTile(
                      label: 'Country',
                      value: viewModel.selectedCountry,
                      onTap: () => CountryPicker.show(context, viewModel),
                    ),
                    SizedBox(height: 3.h),
                    SelectTile(
                      label: 'Region',
                      value: viewModel.selectedRegion,
                      onTap: () => RegionPicker.show(context, viewModel, true),
                    ),
                    SizedBox(height: 3.h),
                    SelectTile(
                      label: 'Region',
                      value: viewModel.selectedRegion2,
                      onTap: () => RegionPicker.show(context, viewModel, false),
                    ),

                    SizedBox(height: 24.h),

                    // Date Section
                    Text(
                      'Destination',
                      style: TextStyle(
                        fontSize: FontSizes.f16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: DateFieldWidget(
                            label: 'From',
                            date: viewModel.fromDate,
                            isFrom: true,
                            onTapDate: (isFrom) => _selectDate(context, isFrom),
                          ),
                        ),

                        SizedBox(width: 12.w),
                        Expanded(
                          child: DateFieldWidget(
                            label: 'To',
                            date: viewModel.fromDate,
                            isFrom: true,
                            onTapDate: (isFrom) => _selectDate(context, isFrom),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Status Section
                    Text(
                      'Destination',
                      style: TextStyle(
                        fontSize: FontSizes.f16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        StatusChip(label: 'Submitted', viewModel: viewModel),
                        StatusChip(
                          label: 'Documents Verified',
                          viewModel: viewModel,
                        ),
                        StatusChip(
                          label: 'Payment Configuration',
                          viewModel: viewModel,
                        ),
                        StatusChip(
                          label: 'Decision Pending',
                          viewModel: viewModel,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(17.r),
                  bottomRight: Radius.circular(17.r),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      textColor: AppColors.blue2,
                      text: "Clear Filters",
                      bgColor: AppColors.white,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    // flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        // Apply filters (keeps same behaviour as before)
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        elevation: 0,
                      ),
                      child: Text(
                        'Apply Filters',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: FontSizes.f16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to show the dialog (kept intact)
// void showFiltersDialog(BuildContext context) {
//   showDialog(context: context, builder: (context) => const FiltersDialog());
// }
