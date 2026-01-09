import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/commen/progress_indicator.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/onboarding/international_students_viewmodel.dart';
import 'package:mvtravel/views/onboarding/Work_Application_Details.dart';
import 'package:mvtravel/views/onboarding/loading_page.dart';
import 'package:provider/provider.dart';

class InternationalStudentsView extends StatelessWidget {
  const InternationalStudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InternationalStudentsViewModel(),
      child: Consumer<InternationalStudentsViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: AppColors.grey,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.black),
                onPressed: () => Nav.pop(context),
              ),
              title: Padding(
                padding: EdgeInsets.only(left: 70.w),
                child: Text(
                  "Student Details",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: FontSizes.f16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              backgroundColor: AppColors.grey,
              elevation: 0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: ListView(
                children: [
                  SizedBox(height: 30.h),
                  StepIndicator(totalSteps: 9, currentStep: 6),
                  SizedBox(height: 40.h),
                  Text(
                    "Academic Information",
                    style: TextStyle(
                      fontSize: FontSizes.f20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // ========== UNIVERSITY NAME ==========
                  Text(
                    "Name of University of Institution",
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 40.h,
                    child: TextField(
                      onChanged: vm.setUniversityName,

                      decoration: InputDecoration(
                        hintText: "e.g., University of Toronto",
                        hintStyle: TextStyle(
                          fontSize: FontSizes.f14,
                          color: AppColors.grey2,
                        ),

                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // ========== ADMISSION STATUS ==========
                  Text(
                    "What is your admission Status?",
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 55.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          _statusButton(vm, "Accepted", AppColors.blue1),
                          SizedBox(width: 10.w),
                          _statusButton(vm, "Pending", AppColors.grey1),
                          SizedBox(width: 10.w),
                          _statusButton(vm, "Applied", AppColors.grey1),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),

                  // ========== STUDY LEVEL DROPDOWN ==========
                  Text(
                    "What is your intended level of study?",
                    style: TextStyle(
                      fontSize: FontSizes.f14,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButton<String>(
                      value: vm.model.studyLevel,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ), // current selected value
                      hint: Text(
                        "Select your study level",
                        style: TextStyle(
                          fontSize: FontSizes.f14,
                          color: AppColors.grey2,
                        ),
                      ),
                      underline: SizedBox(),
                      isExpanded: true,
                      items: vm.studyLevels.map((e) {
                        // map over the list of options, not the selected value
                        return DropdownMenuItem<String>(
                          value: e,

                          child: Text(
                            e,
                            style: TextStyle(
                              fontSize: FontSizes.f14,
                              color: AppColors.grey2,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: vm.setStudyLevel, // update ViewModel
                    ),
                  ),
                  // SizedBox(height: 40.h), SizedBox(height: 35.h),
                  SizedBox(height: 255.h),
                  // ========== SAVE BUTTON ==========
                  FRectangleButton(
                    text: "Next",
                    color: AppColors.blue3,
                    onPressed: () async {
                      final vm = context.read<InternationalStudentsViewModel>();
                      await vm.saveToFirebase(); // Save data to Firebase
                      Nav.push(context, LoadingScreenView());
                    },
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Small method to generate buttons
  Widget _statusButton(
    InternationalStudentsViewModel vm,
    String text,
    Color color,
  ) {
    final bool isActive = vm.model.admissionStatus == text;

    return Expanded(
      child: GestureDetector(
        onTap: () => vm.setAdmissionStatus(text),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isActive ? AppColors.blue1 : AppColors.grey,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: FontSizes.f14,
              color: isActive ? AppColors.white : AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
