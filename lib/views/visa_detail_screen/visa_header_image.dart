import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/home_page_model.dart';
import 'package:mvtravel/utilis/colors.dart';

class HeaderImage extends StatelessWidget {
  final TravelDestination destination;
  const HeaderImage({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 360.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(destination.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                  size: 20.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
