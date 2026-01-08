import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/views/home/callView.dart';
import 'package:mvtravel/views/home/documents.dart';
import 'package:mvtravel/views/whastapp.dart';

class FloatingButtonsWidget extends StatelessWidget {
  const FloatingButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          shape: CircleBorder(),
          heroTag: 'phone',
          onPressed: () {
            Nav.push(context, ContactProfileScreen());
          },
          backgroundColor: AppColors.blue1,
          child: Icon(Icons.phone, color: Colors.white),
        ),
        SizedBox(height: 12.h),

        SizedBox(height: 12.h),

        FloatingActionButton(
          shape: CircleBorder(),
          heroTag: 'chat2',
          onPressed: () {
            Nav.push(context, ContactNumberScreen());
          },
          backgroundColor: AppColors.green1,
          child: Icon(Icons.chat_bubble, color: Colors.white),
        ),
        SizedBox(height: 100.h),
      ],
    );
  }
}
