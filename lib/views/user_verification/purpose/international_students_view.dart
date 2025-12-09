import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/commen/full_size_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/international_students_viewmodel.dart';
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
              backgroundColor: AppColors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: ListView(
                children: [
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
                      fontWeight: FontWeight.w400,
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
                        fillColor: AppColors.white,
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
                      fontWeight: FontWeight.w400,
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
                      color: AppColors.grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButton<String>(
                      value: vm.model.studyLevel,
                      underline: SizedBox(),
                      isExpanded: true,
                      items: ["Undergraduate", "Graduate", "PhD", "Post Doc"]
                          .map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(fontSize: FontSizes.f14),
                              ),
                            );
                          })
                          .toList(),
                      onChanged: vm.setStudyLevel,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // ========== SAVE BUTTON ==========
                  FRectangleButton(
                    text: "Save",
                    color: AppColors.blue3,
                    onPressed: vm.save,
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
