import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/commen/full_size_button.dart';
import 'package:mvtravel/utilis/commen/progress_indicator.dart';
import 'package:mvtravel/utilis/commen/widgets/skip_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/birthdate_viewmodel.dart';
import 'package:mvtravel/views/user_verification/nationality_residence.dart';
import 'package:provider/provider.dart';

class BirthDateScreen extends StatelessWidget {
  const BirthDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BirthDateViewModel(),
      child: Consumer<BirthDateViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: AppColors.grey,
            appBar: AppBar(
              backgroundColor: AppColors.grey,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Nav.pop(context),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: SkipButton(
                    onPressed: () {
                      NationalityResidenceScreen();
                    },
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepIndicator(totalSteps: 3, currentStep: 2),
                  SizedBox(height: 32),
                  Text(
                    'Select your Birth Date',
                    style: TextStyle(
                      fontSize: FontSizes.f20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 32),
                  GestureDetector(
                    onTap: () => vm.pickDate(context),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.grey2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.grey2,
                          ),
                          SizedBox(width: 12),
                          Text(
                            vm.dateController.text.isEmpty
                                ? 'mm / dd / yyyy'
                                : vm.dateController.text,
                            style: TextStyle(
                              fontSize: FontSizes.f16,
                              color: vm.dateController.text.isEmpty
                                  ? AppColors.grey2
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  FRectangleButton(
                    text: 'Next',
                    color: AppColors.blue3,
                    onPressed: () =>
                        Nav.push(context, NationalityResidenceScreen()),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
