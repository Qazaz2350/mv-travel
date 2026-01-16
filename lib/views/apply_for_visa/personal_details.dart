// ignore_for_file: deprecated_member_use
import 'package:country_flags/country_flags.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/app_text_field.dart';
import 'package:mvtravel/commen/country_list.dart';
import 'package:mvtravel/widgets/calender.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/view_model/apply_process_viewmodel.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class DetailStepView extends StatefulWidget {
  final String country;

  final String city;
  final String flag;

  const DetailStepView({
    super.key,
    required this.country,
    required this.city,
    required this.flag,
  });

  @override
  State<DetailStepView> createState() => _DetailStepViewState();
}

class _DetailStepViewState extends State<DetailStepView> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final detailVM = context.read<DetailViewModel>();
      detailVM.fetchUserDataFromFirestore();
    });
  }

  Widget build(BuildContext context) {
    final vm = context.watch<DetailViewModel>(); // shared instance

    return _card(
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: vm.fullNameController,
            ),
            SizedBox(height: 16.h),

            AppTextField(
              label: 'Email Address',
              hint: 'you@example.com',
              controller: vm.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.h),
            _dropdownFieldCountry(
              context,
              'Nationality',
              'Select your nationality',
              vm.selectedNationality, // stores country name
              countryList,
              (value) {
                // value is the country code, convert to name
                final selected = countryList.firstWhere(
                  (c) => c.code == value,
                  orElse: () => countryList.first,
                );
                vm.selectedNationality = selected.code;

                vm.notifyListeners();
              },
            ),
            SizedBox(height: 16.h),
            _dropdownFieldCountry(
              context,
              'Country Platform',
              'Select your platform country',
              vm.selectedPlatformcountry, // ✅ use platform country
              countryList,
              (value) {
                if (value != null) {
                  final selected = countryList.firstWhere(
                    (c) => c.code == value,
                    orElse: () => countryList.first,
                  );
                  vm.selectedPlatformcountry =
                      selected.code; // ✅ update platform country
                  vm.notifyListeners();
                }
              },
            ),

            SizedBox(height: 16.h),
            _phoneField(vm),
            SizedBox(height: 16.h),
            AppTextField(
              label: 'City Platform',
              hint: 'Flight origin city ',
              controller: vm.platfromController,
            ),
            SizedBox(height: 16.h),

            _dropdownField(
              context,
              'Visa Type',
              'Select Visa Type', // generic hint
              vm.selectedVisaType,
              visaTypeList, // ✅ pick directly from list
              (value) {
                vm.selectedVisaType = value;
                vm.notifyListeners();
              },
            ),

            SizedBox(height: 16.h),

            AppTextField(
              label: 'Address',
              hint: 'address home town',
              controller: vm.addressController,
              maxLines: 2,
            ),
            SizedBox(height: 16.h),

            AppDateField(
              label: 'Birth Date',
              hint: 'Select your birth date',
              controller: vm.dobController,
              onTap: () => vm.selectDate(context),
            ),

            SizedBox(height: 16.h),

            // SizedBox(height: 16.h),

            // SizedBox(height: 240.h),
          ],
        ),
      ),
    );
  }

  // ================= HELPERS =================
  Widget _card(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child,
    );
  }

  Widget _dropdownFieldCountry(
    BuildContext context,
    String label,
    String hint,
    String? selectedCode, // ISO code stored
    List<Country> countries,
    Function(String?) onChanged,
  ) {
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
        DropdownButtonFormField2<String>(
          isExpanded: true,
          value: countries.any((c) => c.code == selectedCode)
              ? selectedCode
              : null,
          hint: Text(
            hint,
            style: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey1),
            ),
          ),
          items: countries
              .map(
                (country) => DropdownMenuItem(
                  value: country.code,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.w),
                        child: CountryFlag.fromCountryCode(
                          country.code.toLowerCase(),
                          theme: const ImageTheme(width: 22, height: 14),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        country.name,
                        style: TextStyle(
                          fontSize: FontSizes.f14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          dropdownStyleData: DropdownStyleData(
            maxHeight: 250.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.white,
            ),
            offset: Offset(0, 0),
          ),
        ),
      ],
    );
  }

  Widget _dropdownField(
    BuildContext context,
    String label,
    String hint,
    String? selectedValue,
    List<String> items,
    Function(String?) onChanged,
  ) {
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
        DropdownButtonFormField2<String>(
          isExpanded: true,
          value: items.contains(selectedValue)
              ? selectedValue
              : null, // safe check
          hint: Text(
            hint,
            style: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 14.h,
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      color: AppColors.grey2,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          dropdownStyleData: DropdownStyleData(
            maxHeight: 250.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.white,
            ),
            offset: Offset(0, 0),
          ),
        ),
      ],
    );
  }

  Widget _phoneField(DetailViewModel vm) {
    final isValidDialCode = countryList.any(
      (c) => c.dialCode == vm.selectedDialCode,
    );

    if (!isValidDialCode) {
      vm.selectedDialCode = countryList.first.dialCode;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                value: countryList.any((c) => c.dialCode == vm.selectedDialCode)
                    ? vm.selectedDialCode
                    : countryList.first.dialCode,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.grey2.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: AppColors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 14.h,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200.h, // allow enough height
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  // remove 'offset' entirely for automatic positioning
                ),

                items: countryList.map((country) {
                  return DropdownMenuItem<String>(
                    value: country.dialCode,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryFlag.fromCountryCode(
                            country.code.toLowerCase(),
                            theme: const ImageTheme(width: 22, height: 14),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "(${country.dialCode})",
                            style: TextStyle(
                              fontSize: FontSizes.f14,
                              color: AppColors.grey2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    vm.selectedDialCode = value;
                    vm.notifyListeners();
                  }
                },
              ),
            ),

            SizedBox(width: 12.w),
            Expanded(
              flex: 4,
              child: TextField(
                controller: vm.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'xxx-xxx-xxxx',
                  hintStyle: TextStyle(
                    color: AppColors.grey2,
                    fontSize: FontSizes.f14,
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.grey2.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.grey2.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: AppColors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
