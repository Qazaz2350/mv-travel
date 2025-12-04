import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/colors.dart';

class StepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep; // 1-based

  const StepIndicator({
    Key? key,
    required this.totalSteps,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: index < currentStep ? AppColors.blue1 : AppColors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
