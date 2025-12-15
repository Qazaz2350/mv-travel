import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/home_page_model.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/onboarding/visa_detail_view_model.dart';

class FAQSection extends StatelessWidget {
  final VisaDetailViewModel viewModel;
  final TravelDestination destination;
  const FAQSection({required this.viewModel, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          Text(
            'Everything you need to know about the product and billing.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 4.h),
          ...List.generate(destination.faqs!.length, (index) {
            final item = destination.faqs![index];
            return _buildFAQItem(context, index, item.question, item.answer);
          }),
        ],
      ),
    );
  }

  Widget _buildFAQItem(
    BuildContext context,
    int index,
    String question,
    String answer,
  ) {
    final isExpanded = viewModel.expandedIndex == index;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey1, width: 1)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => viewModel.toggleFAQ(index),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.remove_circle_outline
                        : Icons.add_circle_outline,
                    color: AppColors.grey2,
                    size: 24.w,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h, right: 40.w),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey2,
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
