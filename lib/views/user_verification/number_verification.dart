import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/commen/full_size_button.dart';
import 'package:mvtravel/utilis/commen/progress_indicator.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/views/user_verification/select_birthdate.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+92';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Nav.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Nav.push(context, BirthDateScreen()),
            child: Text(
              'Skip',
              style: TextStyle(
                color: AppColors.blue1,
                fontSize: FontSizes.f16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepIndicator(totalSteps: 3, currentStep: 1), // Reusable Indicator
            SizedBox(height: 32),
            Text(
              'What is your phone number?',
              style: TextStyle(
                fontSize: FontSizes.f28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We need your phone number to provide status updates on your visa',
              style: TextStyle(
                fontSize: FontSizes.f14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.blue1, width: 2),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCountryCode,
                      items: ['+92', '+1', '+44', '+91']
                          .map(
                            (code) => DropdownMenuItem(
                              value: code,
                              child: Text(code),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCountryCode = value!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: FontSizes.f16),
                    decoration: InputDecoration(
                      hintText: '312 456 789',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.blue1,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            FRectangleButton(
              text: 'Next',
              color: AppColors.blue3,
              onPressed: () => Nav.push(context, BirthDateScreen()),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
