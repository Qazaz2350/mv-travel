import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/commen/progress_indicator.dart';
import 'package:mvtravel/commen/skip_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/onboarding/birthdate_viewmodel.dart';
import 'package:mvtravel/views/onboarding/nationality_residence.dart';
import 'package:mvtravel/widgets/message.dart';
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
                      Nav.push(context, NationalityResidenceScreen());
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
                  StepIndicator(totalSteps: 9, currentStep: 2),
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
                    onPressed: () async {
                      final vm = context.read<BirthDateViewModel>();

                      // ✅ Validation: check if birth date is selected
                      if (!vm.isValid) {
                        showCustomSnackBar(
                          context,
                          'Please select your birth date',
                          isError: true,
                        );
                        return;
                      }

                      final user = FirebaseAuth.instance.currentUser;

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .set(vm.toMap(), SetOptions(merge: true));

                      Nav.push(context, NationalityResidenceScreen());
                    },
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
