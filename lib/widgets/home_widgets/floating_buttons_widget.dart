import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';

class FloatingButtonsWidget extends StatelessWidget {
  const FloatingButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'phone',
          onPressed: () {},
          backgroundColor: AppColors.blue1,
          child: Icon(Icons.phone, color: Colors.white),
        ),
        SizedBox(height: 12.h),

        FloatingActionButton(
          heroTag: 'chat1',
          onPressed: () {},
          backgroundColor: Colors.pink,
          child: Text(
            'H',
            style: TextStyle(
              color: Colors.white,
              fontSize: FontSizes.f20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 12.h),

        FloatingActionButton(
          heroTag: 'chat2',
          onPressed: () {},
          backgroundColor: AppColors.green1,
          child: Icon(Icons.chat_bubble, color: Colors.white),
        ),
        SizedBox(height: 12.h),

        FloatingActionButton(
          heroTag: 'chat3',
          onPressed: () {},
          backgroundColor: Colors.pink,
          child: Text(
            'H',
            style: TextStyle(
              color: Colors.white,
              fontSize: FontSizes.f20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
