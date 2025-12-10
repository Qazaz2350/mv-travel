import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/commen/full_size_button.dart';
import 'package:mvtravel/utilis/commen/progress_indicator.dart';
import 'package:mvtravel/view_model/work_application_details_viewmodel.dart';
import 'package:mvtravel/utilis/Nav.dart';
import 'package:mvtravel/views/user_verification/purpose/Investment%20Details.dart';

class WorkApplicationDetailsView extends StatefulWidget {
  const WorkApplicationDetailsView({Key? key}) : super(key: key);

  @override
  State<WorkApplicationDetailsView> createState() =>
      _WorkApplicationDetailsViewState();
}

class _WorkApplicationDetailsViewState
    extends State<WorkApplicationDetailsView> {
  late WorkApplicationDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = WorkApplicationDetailsViewModel();
    _viewModel.addListener(_onViewModelChanged);
  }

  void _onViewModelChanged() => setState(() {});

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  // Future<void> _handleSave() async {
  //   final success = await _viewModel.saveWorkDetails();

  //   if (success && mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Work details saved successfully'),
  //         backgroundColor: AppColors.green1,
  //       ),
  //     );
  //   } else if (_viewModel.errorMessage != null && mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(_viewModel.errorMessage!),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
          'Work Application Details',
          style: TextStyle(
            color: AppColors.black,
            fontSize: FontSizes.f16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _viewModel.isLoading
          ? Center(child: CircularProgressIndicator(color: AppColors.blue1))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    StepIndicator(totalSteps: 9, currentStep: 7),
                    SizedBox(height: 32.h),

                    Text(
                      'Work Details',
                      style: TextStyle(
                        fontSize: FontSizes.f20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    _buildTextField(
                      label: 'Job Title',
                      controller: _viewModel.jobTitleController,
                      hint: 'e.g., Software Engineer',
                    ),

                    SizedBox(height: 20.h),

                    _buildTextField(
                      label: 'Relevant Experience',
                      controller: _viewModel.experienceController,
                      hint: 'Describe your past roles and responsibilities...',
                      maxLines: 4,
                    ),

                    SizedBox(height: 24.h),

                    _buildJobOfferSection(),

                    SizedBox(height: 24.h),

                    _buildUploadSection(),

                    SizedBox(height: 24.h),

                    _buildTextField(
                      label: 'Expected Annual Salary',
                      controller: _viewModel.salaryController,
                      hint: '\$ 0.00',
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                      prefixText: '\$ ',
                    ),

                    SizedBox(height: 40.h),

                    FRectangleButton(
                      text: 'Next',
                      color: AppColors.blue3,
                      onPressed: () {
                        Nav.push(context, const InvestmentDetailsView());
                      },
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
    );
  }

  // ------------------------------------------------
  // UI Helper Widgets (unchanged)
  // ------------------------------------------------
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? prefixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: TextStyle(fontSize: FontSizes.f14, color: AppColors.black),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: FontSizes.f14,
                color: AppColors.grey2,
              ),
              prefixText: prefixText,
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

  Widget _buildJobOfferSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do you have a confirmed job offer?',
          style: TextStyle(
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildOptionButton(
                    'Yes',
                    _viewModel.workData.hasJobOffer,
                    () => _viewModel.updateJobOfferStatus(true),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildOptionButton(
                    'No',
                    !_viewModel.workData.hasJobOffer,
                    () => _viewModel.updateJobOfferStatus(false),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blue1 : AppColors.grey,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: FontSizes.f14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Job Offer Letter',
          style: TextStyle(
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: _viewModel.isPickingFile ? null : _viewModel.pickOfferLetter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.grey1,
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: _viewModel.workData.offerLetterFileName.isNotEmpty
                ? _buildUploadedFile()
                : _buildUploadPlaceholder(),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPlaceholder() {
    return Column(
      children: [
        Icon(Icons.cloud_upload_outlined, size: 48.sp, color: AppColors.grey2),
        SizedBox(height: 8.h),
        Text(
          'PDF, DOCX (Max 5MB)',
          style: TextStyle(fontSize: FontSizes.f12, color: AppColors.grey2),
        ),
      ],
    );
  }

  Widget _buildUploadedFile() {
    return Row(
      children: [
        Icon(Icons.description, size: 32.sp, color: AppColors.blue1),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            _viewModel.workData.offerLetterFileName,
            style: TextStyle(
              fontSize: FontSizes.f14,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: Colors.red),
          onPressed: _viewModel.removeOfferLetter,
        ),
      ],
    );
  }
}
