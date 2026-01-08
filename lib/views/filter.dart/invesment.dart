import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/view_model/filters_viewmodel.dart'; // Keep JobFilterViewModel
import 'package:provider/provider.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class InvestmentFiltersScreen extends StatelessWidget {
  const InvestmentFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JobFilterViewModel(), // reusing same ViewModel
      child: Consumer<JobFilterViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Keywords / Investment Name
                    _buildTextField(
                      controller: vm.keywordsController,
                      hint: 'Keywords / Investment Name',
                      icon: Icons.search,
                    ),
                    SizedBox(height: 16.h),

                    // Location + Distance
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildTextField(
                            controller: vm.locationController,
                            hint: 'Location',
                            icon: Icons.location_on_outlined,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildDropdownField(
                            hint: vm.selectedDistance,
                            onTap: () => _showPicker(
                              context,
                              'Select Distance',
                              vm.distanceOptions,
                              vm.selectedDistance,
                              vm.setDistance,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Investment Type + Risk Level
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            hint: 'Investment',
                            onTap: () => _showPicker(
                              context,
                              'Investment Type',
                              [
                                'Stocks',
                                'Bonds',
                                'Real Estate',
                                'Mutual Funds',
                                'Cryptocurrency',
                              ],
                              '',
                              (val) {},
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildDropdownField(
                            hint: 'Risk Level',
                            onTap: () => _showPicker(
                              context,
                              'Risk Level',
                              ['Low', 'Medium', 'High'],
                              '',
                              (val) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Investment Amount Min + Max
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: vm.salaryMinController,
                            hint: 'Amount Min',
                            icon: Icons.attach_money,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildTextField(
                            controller: vm.salaryMaxController,
                            hint: 'Amount Max',
                            icon: Icons.attach_money,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.grey1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: FontSizes.f14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.grey2),
          prefixIcon: Icon(icon, color: AppColors.grey2),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.grey1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                hint,
                style: TextStyle(
                  fontSize: FontSizes.f14,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: AppColors.blue2),
          ],
        ),
      ),
    );
  }

  void _showPicker(
    BuildContext context,
    String title,
    List<String> options,
    String selectedValue,
    Function(String) onSelected,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: EdgeInsets.only(
            top: 16.h,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.r,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: FontSizes.f20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grey.withOpacity(0.2),
                        ),
                        child: Icon(Icons.close, size: 20.r),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 1),

              // Options
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (_, index) {
                    final option = options[index];
                    final isSelected = option == selectedValue;
                    return InkWell(
                      onTap: () {
                        onSelected(option);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.blue1.withOpacity(0.15)
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? AppColors.blue2
                                    : AppColors.black,
                              ),
                            ),
                            if (isSelected)
                              Icon(Icons.check, color: AppColors.blue2),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        );
      },
    );
  }
}
