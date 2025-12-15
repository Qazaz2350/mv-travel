import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/home_page_model.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/views/visa_detail_screen/helper.dart';

class VisaInfoSection extends StatelessWidget {
  final TravelDestination destination;
  const VisaInfoSection({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visa Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          buildInfoRow(
            'Visa Type: ',
            destination.visaType ?? '-',
            'Entry: ',
            destination.entry ?? '-',
          ),
          SizedBox(height: 8.h),
          buildInfoRow(
            'Length of Stay: ',
            destination.lengthOfStay ?? '-',
            'Validity: ',
            destination.visaType ?? '-',
          ),
          SizedBox(height: 8.h),
          Divider(color: AppColors.grey1, thickness: 1),
        ],
      ),
    );
  }
}
