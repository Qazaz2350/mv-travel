// ActiveApplicationWidget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/visa_tracking_model.dart';
import 'package:mvtravel/view_model/visa_tracking_view_model.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/Nav.dart';
import 'package:mvtravel/views/visa_tracking/visa_tracking.dart';
import 'package:mvtravel/views/home/tracking_card_home.dart';
import 'package:provider/provider.dart';

class ActiveApplicationWidget extends StatelessWidget {
  const ActiveApplicationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final visaVM = context.watch<VisaTrackingViewModel>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Application',
                style: TextStyle(
                  fontSize: FontSizes.f20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Nav.push(
                    context,
                    ChangeNotifierProvider(
                      create: (_) => VisaTrackingViewModel(),
                      child: const VisaTracking(),
                    ),
                  );
                },
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: FontSizes.f14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          /// ✅ Correct data passed
          ApplicationCardWidget(applicationList: visaVM.applications),
        ],
      ),
    );
  }
}
