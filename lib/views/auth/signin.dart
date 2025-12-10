import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/commen/full_size_button.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/sign_in_view_model.dart';
import 'package:mvtravel/views/number_verification.dart';
// import 'sign_in_view_model.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

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
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: AppColors.grey,
            appBar: AppBar(
              backgroundColor: AppColors.grey,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black87, size: 26),
                onPressed: () => Navigator.pop(context),
              ),
              title: Padding(
                padding: EdgeInsets.only(left: 60.w),
                child: Text(
                  "Sign In to Continue",
                  style: TextStyle(
                    color: AppColors.blue3,
                    fontSize: FontSizes.f14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.all(24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
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
                        validator: vm.validatePassword,
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
                          onTap: () {
                            Nav.push(context, PhoneNumberScreen());
                          },
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
                      SizedBox(height: 30.h),
                      FRectangleButton(
                        text: 'Sign In',
                        color: AppColors.blue3,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            vm.signIn(() {
                              // navigate or show success
                            });
                          }
                        },
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
}
