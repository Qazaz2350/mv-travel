import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/home_page_model.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/onboarding/visa_detail_view_model.dart';
import 'package:provider/provider.dart';

class VisaDetailScreen extends StatelessWidget {
  final TravelDestination destination;

  const VisaDetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VisaDetailViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.grey,
        body: Column(
          children: [Expanded(child: _Content(destination: destination))],
        ),
        bottomSheet: _BottomBar(destination: destination),
      ),
    );
  }
}

// ------------------- Header Image -------------------
class _HeaderImage extends StatelessWidget {
  final TravelDestination destination;
  const _HeaderImage({required this.destination});

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

// ------------------- Content -------------------
class _Content extends StatelessWidget {
  final TravelDestination destination;
  const _Content({required this.destination});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<VisaDetailViewModel>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderImage(destination: destination),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              '${destination.country}, ${destination.cityName}',
              style: TextStyle(
                fontSize: FontSizes.f20,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
          if (destination.visaType != null ||
              destination.entry != null ||
              destination.lengthOfStay != null)
            _VisaInfoSection(destination: destination),
          if (destination.documents != null &&
              destination.documents!.isNotEmpty)
            _DocumentsRequiredSection(destination: destination),
          if (destination.faqs != null && destination.faqs!.isNotEmpty)
            _FAQSection(viewModel: viewModel, destination: destination),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}

// ------------------- Visa Info -------------------
class _VisaInfoSection extends StatelessWidget {
  final TravelDestination destination;
  const _VisaInfoSection({required this.destination});

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
              fontSize: FontSizes.f16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
            'Visa Type:',
            destination.visaType ?? '-',
            'Entry:',
            destination.entry ?? '-',
          ),
          SizedBox(height: 8.h),
          _buildInfoRow(
            'Length of Stay:',
            destination.lengthOfStay ?? '-',
            'Validity:',
            destination.visaType ?? '-',
          ),
          SizedBox(height: 8.h),
          Divider(color: AppColors.grey1, thickness: 1),
        ],
      ),
    );
  }
}

// ------------------- Documents -------------------
class _DocumentsRequiredSection extends StatelessWidget {
  final TravelDestination destination;
  const _DocumentsRequiredSection({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documents Required',
            style: TextStyle(
              fontSize: FontSizes.f16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          ...destination.documents!.map(
            (doc) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: _buildDocumentItem(
                doc,
                'Auto-Scanned. Auto-Filled. No manual error.',
              ),
            ),
          ),
          Divider(color: AppColors.grey1, thickness: 1),
        ],
      ),
    );
  }
}

// ------------------- FAQ -------------------
class _FAQSection extends StatelessWidget {
  final VisaDetailViewModel viewModel;
  final TravelDestination destination;
  const _FAQSection({required this.viewModel, required this.destination});

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
              fontSize: FontSizes.f20,
              fontWeight: FontWeight.w600,
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
                        fontSize: FontSizes.f16,
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
                  fontSize: FontSizes.f14,
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

// ------------------- Bottom Bar -------------------
class _BottomBar extends StatelessWidget {
  final TravelDestination destination;
  const _BottomBar({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pay Now',
                    style: TextStyle(
                      fontSize: FontSizes.f12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'PKR ${destination.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: TextStyle(
                      fontSize: FontSizes.f20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue2,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Apply Now',
                  style: TextStyle(
                    fontSize: FontSizes.f16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Helpers -------------------
Widget _buildInfoRow(
  String label1,
  String value1,
  String label2,
  String value2,
) {
  return Row(
    children: [
      Expanded(
        child: Row(
          children: [
            Text(
              label1,
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w400,
                color: AppColors.grey2,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              value1,
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            Text(
              label2,
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w400,
                color: AppColors.grey2,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              value2,
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildDocumentItem(String title, String subtitle) {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: AppColors.white,
    ),
    child: Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.green1.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: ImageIcon(
            AssetImage('assets/home/tik.png'),
            color: AppColors.green1,
            size: 24.w,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: FontSizes.f12,
                fontWeight: FontWeight.w400,
                color: AppColors.grey2,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
