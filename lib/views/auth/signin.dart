import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:mvtravel/view_model/auth/sign_in_view_model.dart';
import 'package:mvtravel/views/home/home_dashboard.dart';
import 'package:mvtravel/views/auth/signup.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/nav.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: FontSizes.f14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[700],
              fontSize: FontSizes.f14,
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
              borderSide: BorderSide(color: AppColors.blue2, width: 2.w),
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInViewModel(),
      child: Consumer<SignInViewModel>(
        builder: (context, vm, _) => Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.white,

            title: Center(
              child: Text(
                "Sign In to Continue",
                style: TextStyle(
                  color: AppColors.blue3,
                  fontSize: FontSizes.f16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(color: AppColors.white),
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: FontSizes.f20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Sign in to continue your visa application process.',
                      style: TextStyle(
                        fontSize: FontSizes.f14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    _buildTextField(
                      label: 'Email Address',
                      controller: vm.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'you@example.com',
                      validator: vm.validateEmail,
                    ),
                    SizedBox(height: 20.h),
                    _buildTextField(
                      label: 'Password',
                      controller: vm.passwordController,
                      obscureText: !vm.isPasswordVisible,
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          vm.isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        onPressed: vm.togglePasswordVisibility,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: AppColors.blue3,
                            fontSize: FontSizes.f14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 340.h),
                    FRectangleButton(
                      text: vm.isLoading ? 'Signing in...' : 'Sign In',
                      color: AppColors.blue3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          vm.signIn(
                            () {
                              Nav.push(context, HomePageView());
                            },
                            onError: (err) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(err)));
                            },
                          );
                        }
                      },
                    ),
                    // Rest of the UI remains the same
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
