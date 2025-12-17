import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/view_model/apply_process_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/app_text_field.dart';
// import 'payment_viewmodel.dart';

class Paymentdetails extends StatelessWidget {
  const Paymentdetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentViewModel(),
      child: Consumer<PaymentViewModel>(
        builder: (context, vm, _) => Scaffold(
          backgroundColor: AppColors.grey,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Amount Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '\$255.00',
                            style: TextStyle(
                              fontSize: FontSizes.f20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Total amount due for Application #vza45678',
                            style: TextStyle(
                              fontSize: FontSizes.f14,
                              color: AppColors.grey2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.white,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Payment Details',
                                style: TextStyle(
                                  fontSize: FontSizes.f16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Card Number Field
                            _buildCardNumberField(vm),

                            // SizedBox(height: 12.h),

                            // Name on Card
                            AppTextField(
                              label: '',
                              hint: 'Name on Card',
                              controller: vm.nameController,
                              keyboardType: TextInputType.name,
                            ),

                            SizedBox(height: 12.h),

                            Row(
                              children: [
                                Expanded(child: _buildExpiryField(vm)),
                                SizedBox(width: 12.w),
                                Expanded(child: _buildCVVField(vm)),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // PayPal Option
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    _buildPayPalOption(vm),

                    SizedBox(height: 20.h),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            size: 20.sp,
                            color: AppColors.grey2,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Your payment is safe and secure',
                            style: TextStyle(
                              fontSize: FontSizes.f14,
                              color: AppColors.grey2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardNumberField(PaymentViewModel vm) {
    return TextField(
      controller: vm.cardNumberController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        CardNumberFormatter(),
      ],
      decoration: InputDecoration(
        hintText: '0000 0000 0000 0000',
        hintStyle: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.blue2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      ),
    );
  }

  Widget _buildExpiryField(PaymentViewModel vm) {
    return TextField(
      controller: vm.expiryController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        ExpiryDateFormatter(),
      ],
      decoration: InputDecoration(
        hintText: 'MM/YY',
        hintStyle: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.blue2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildCVVField(PaymentViewModel vm) {
    return TextField(
      controller: vm.cvvController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      decoration: InputDecoration(
        hintText: '123',
        hintStyle: TextStyle(color: AppColors.grey2, fontSize: FontSizes.f14),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.grey2.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.blue2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildPayPalOption(PaymentViewModel vm) {
    return InkWell(
      onTap: vm.togglePayPal,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.grey2.withOpacity(0.3)),
        ),
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(Icons.payment, color: AppColors.blue2, size: 24.sp),
            SizedBox(width: 12.w),
            Text(
              'PayPal',
              style: TextStyle(
                fontSize: FontSizes.f16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            Spacer(),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: vm.usePayPal ? AppColors.blue2 : AppColors.grey1,
                  width: 2.w,
                ),
              ),
              child: vm.usePayPal
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blue2,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
