import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/home_page_model.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/onboarding/visa_detail_view_model.dart';
import 'package:mvtravel/views/visa_detail_screen/visa_bottom_bar.dart';
import 'package:mvtravel/views/visa_detail_screen/visa_documents_section.dart';
import 'package:mvtravel/views/visa_detail_screen/visa_faq_section.dart';
import 'package:mvtravel/views/visa_detail_screen/visa_header_image.dart';
import 'package:mvtravel/views/visa_detail_screen/visa_info_section.dart';
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Image
              HeaderImage(destination: destination),

              // Country + City
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

              // Visa Info Section
              if (destination.visaType != null ||
                  destination.entry != null ||
                  destination.lengthOfStay != null)
                VisaInfoSection(destination: destination),

              // Documents Section
              if (destination.documents != null &&
                  destination.documents!.isNotEmpty)
                DocumentsRequiredSection(destination: destination),

              // FAQ Section
              if (destination.faqs != null && destination.faqs!.isNotEmpty)
                Consumer<VisaDetailViewModel>(
                  builder: (context, viewModel, _) => FAQSection(
                    viewModel: viewModel,
                    destination: destination,
                  ),
                ),

              SizedBox(height: 100.h),
            ],
          ),
        ),
        bottomSheet: BottomBar(destination: destination, country: destination.country, city: destination.cityName,),
      ),
    );
  }
}
