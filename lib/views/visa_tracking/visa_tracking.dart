import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/tracking_card.dart';
import 'package:mvtravel/view_model/visa_tracking_view_model.dart';
import 'package:provider/provider.dart';

import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/nav.dart';

class VisaTracking extends StatelessWidget {
  const VisaTracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<VisaTrackingViewModel>();

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Nav.pop(context),
        ),
        title: Text(
          'Active Applrications',
          style: TextStyle(
            color: AppColors.black,
            fontSize: FontSizes.f20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${vm.totalResults} Results',
              style: TextStyle(color: AppColors.grey2),
            ),
            SizedBox(height: 16.h),
            ...vm.applications.map((e) => VisaTrackingPage(data: e)).toList(),
          ],
        ),
      ),
    );
  }
}
