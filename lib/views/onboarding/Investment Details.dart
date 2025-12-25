import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/model/onboarding/investment_details_model.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/commen/progress_indicator.dart';
import 'package:mvtravel/view_model/onboarding/investment_details_viewmodel.dart';
import 'package:mvtravel/utilis/Nav.dart';
import 'package:mvtravel/views/onboarding/loading_page.dart';
import 'package:provider/provider.dart';

class InvestmentDetailsView extends StatelessWidget {
  const InvestmentDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InvestmentDetailsViewModel(),
      child: Consumer<InvestmentDetailsViewModel>(
        builder: (context, viewModel, child) {
          // Future<void> _handleSave() async {
          //   final success = await viewModel.saveInvestmentDetails();
          //   if (success && context.mounted) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text('Investment details saved successfully'),
          //         backgroundColor: AppColors.green1,
          //       ),
          //     );
          //   } else if (viewModel.errorMessage != null && context.mounted) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text(viewModel.errorMessage!),
          //         backgroundColor: Colors.red,
          //       ),
          //     );
          //   }
          // }

          return Scaffold(
            backgroundColor: AppColors.grey,
            appBar: AppBar(
              backgroundColor: AppColors.grey,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.black),
                onPressed: () => Nav.pop(context),
              ),
              title: Text(
                'Investment Details',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: FontSizes.f20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: viewModel.isLoading
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.blue1),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StepIndicator(totalSteps: 9, currentStep: 8),

                          SizedBox(height: 32.h),
                          Text(
                            'Financial Information',
                            style: TextStyle(
                              fontSize: FontSizes.f20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          _buildAmountField(viewModel),
                          SizedBox(height: 20.h),
                          _buildInvestmentTypeDropdown(viewModel),
                          SizedBox(height: 24.h),
                          _buildSupportingDocuments(viewModel),
                          SizedBox(height: 16.h),
                          _buildUploadedDocumentsList(viewModel),
                          SizedBox(height: 150.h),
                          FRectangleButton(
                            text: 'Next',
                            color: AppColors.blue3,
                            onPressed: () async {
                              final success = await viewModel
                                  .saveInvestmentDetails();

                              if (success && context.mounted) {
                                Nav.push(context, LoadingScreenView());
                              } else if (viewModel.errorMessage != null &&
                                  context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(viewModel.errorMessage!),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          ),

                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildAmountField(InvestmentDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Investment Amount',
          style: TextStyle(
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: viewModel.amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            style: TextStyle(fontSize: FontSizes.f14, color: AppColors.black),
            decoration: InputDecoration(
              hintText: '\$ 0.00',
              hintStyle: TextStyle(
                fontSize: FontSizes.f14,
                color: AppColors.grey2,
              ),
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                fontSize: FontSizes.f14,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentTypeDropdown(InvestmentDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type of Investment',
          style: TextStyle(
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: DropdownButtonFormField<InvestmentType>(
            value: viewModel.investmentData.investmentType,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
            hint: Text(
              'Select type',
              style: TextStyle(fontSize: FontSizes.f14, color: AppColors.grey2),
            ),
            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.black),
            style: TextStyle(fontSize: FontSizes.f14, color: AppColors.black),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(12.r),

            // padding: ,
            items: InvestmentType.values.map((type) {
              return DropdownMenuItem<InvestmentType>(
                value: type,

                child: Text(type.displayName),
              );
            }).toList(),
            onChanged: (InvestmentType? newValue) =>
                viewModel.updateInvestmentType(newValue),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportingDocuments(InvestmentDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Supporting Documents',
          style: TextStyle(
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: viewModel.isPickingFile ? null : viewModel.pickDocument,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.grey1, width: 2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 48.sp,
                  color: AppColors.grey2,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Upload Document',
                  style: TextStyle(
                    fontSize: FontSizes.f14,
                    color: AppColors.grey2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'PDF, DOCX (Max 5MB)',
                  style: TextStyle(
                    fontSize: FontSizes.f12,
                    color: AppColors.grey2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadedDocumentsList(InvestmentDetailsViewModel viewModel) {
    if (viewModel.investmentData.uploadedDocuments.isEmpty)
      return SizedBox.shrink();

    return Column(
      children: viewModel.investmentData.uploadedDocuments
          .asMap()
          .entries
          .map(
            (entry) =>
                _buildUploadedDocumentItem(viewModel, entry.value, entry.key),
          )
          .toList(),
    );
  }

  Widget _buildUploadedDocumentItem(
    InvestmentDetailsViewModel viewModel,
    UploadedDocument doc,
    int index,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.grey1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.green1.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, size: 16.sp, color: AppColors.green1),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              doc.fileName,
              style: TextStyle(
                fontSize: FontSizes.f14,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.red, size: 20.sp),
            onPressed: () => viewModel.removeDocument(index),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
