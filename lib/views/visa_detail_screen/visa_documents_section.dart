import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/home_page_model.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/views/visa_detail_screen/helper.dart';

class DocumentsRequiredSection extends StatelessWidget {
  final TravelDestination destination;
  const DocumentsRequiredSection({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Text(
            'Documents Required',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          ...destination.documents!.map(
            (doc) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: buildDocumentItem(
                doc,
                'Auto-Scanned. Auto-Filled. No manual error.',
              ),
            ),
          ),
          Divider(color: AppColors.grey1, thickness: 1),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
