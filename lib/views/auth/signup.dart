import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/view_model/auth/signup_viewmodel.dart';
import 'package:mvtravel/widgets/message.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/views/auth/signin.dart';
import 'package:mvtravel/views/onboarding/number_verification.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,

              title: Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    color: AppColors.blue3,
                    fontSize: FontSizes.f16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20,
              ),
              child: Form(
                key: vm.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: FontSizes.f20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Sign up to begin your visa application process.',
                        style: TextStyle(
                          fontSize: FontSizes.f14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Full Name
                      _buildTextField(
                        label: 'Full Name',
                        controller: vm.fullNameController,
                        hintText: 'Enter your full name',
                      ),
                      SizedBox(height: 16.h),

                      // Email
                      _buildTextField(
                        label: 'Email Address',
                        controller: vm.emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'you@example.com',
                      ),
                      SizedBox(height: 16.h),

                      // Password
                      _buildTextField(
                        label: 'Password',
                        controller: vm.passwordController,
                        obscureText: !vm.isPasswordVisible,
                        hintText: 'Create a password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            vm.isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey[600],
                          ),
                          onPressed: vm.togglePasswordVisibility,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Confirm Password
                      _buildTextField(
                        label: 'Confirm Password',
                        controller: vm.confirmPasswordController,
                        obscureText: !vm.isConfirmPasswordVisible,
                        hintText: 'Confirm your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            vm.isConfirmPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey[600],
                          ),
                          onPressed: vm.toggleConfirmPasswordVisibility,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Agree to terms
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Checkbox(
                              value: vm.agreeToTerms,
                              onChanged: (value) =>
                                  vm.agreeToTerms = value ?? false,
                              activeColor: AppColors.blue2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: FontSizes.f12.sp,
                                  color: Colors.grey[700],
                                ),
                                children: [
                                  TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: TextStyle(
                                      color: AppColors.blue3,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: AppColors.blue3,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),

                      FRectangleButton(
                        text: vm.isLoading ? 'Creating...' : 'Create Account',
                        color: AppColors.blue3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        onPressed: () async {
                          if (!vm.agreeToTerms) {
                            showCustomSnackBar(
                              context,
                              'Please accept terms & conditions',
                            );
                            return;
                          }

                          if (!vm.agreeToTerms) {
                            showCustomSnackBar(
                              context,
                              'Please accept terms & conditions',
                              isError: true,
                            );
                            return;
                          }

                          try {
                            final success = await vm.signUp();
                            if (success) {
                              showCustomSnackBar(
                                context,
                                'Account created successfully!',
                              );
                              Nav.push(context, PhoneNumberScreen());
                            }
                          } catch (e) {
                            showCustomSnackBar(
                              context,
                              e.toString(),
                              isError: true,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h),
                          Text(
                            "_______________",
                            style: TextStyle(color: AppColors.grey1),
                          ),
                          Text(
                            "  OR Signup With ",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: FontSizes.f12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "_______________",
                            style: TextStyle(color: AppColors.grey1),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      Row(
                        children: [
                          _buildSocialButton(
                            text: 'Google',
                            icon: Image.network(
                              'https://www.google.com/favicon.ico',
                              width: 20.w,
                              height: 20.h,
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(width: 12.w),
                          _buildSocialButton(
                            text: 'Apple',
                            icon: Icon(
                              Icons.apple,
                              color: Colors.black,
                              size: 24.sp,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account ?  ',
                            style: TextStyle(
                              fontSize: FontSizes.f14.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Nav.push(context, SignInScreen());
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: FontSizes.f14.sp,
                                color: AppColors.blue2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: FontSizes.f14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }

            if (label == 'Email Address') {
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Enter a valid email address';
              }
            }

            if (label == 'Password') {
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
            }

            if (label == 'Confirm Password') {
              if (value != controller.text) {
                return 'Passwords do not match';
              }
            }

            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[700],
              fontSize: FontSizes.f14.sp,
            ),
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.blue2, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 9.h,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String text,
    Widget? icon,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon ?? const SizedBox.shrink(),
        label: Text(
          text,
          style: TextStyle(
            fontSize: FontSizes.f14.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          side: BorderSide(color: Colors.grey[300]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
          backgroundColor: AppColors.grey,
        ),
      ),
    );
  }
}
