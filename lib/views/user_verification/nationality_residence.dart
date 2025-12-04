import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/commen/full_size_button.dart';
import 'package:mvtravel/utilis/commen/progress_indicator.dart';
import 'package:mvtravel/utilis/nav.dart';

class NationalityResidenceScreen extends StatefulWidget {
  const NationalityResidenceScreen({Key? key}) : super(key: key);

  @override
  State<NationalityResidenceScreen> createState() =>
      _NationalityResidenceScreenState();
}

class _NationalityResidenceScreenState
    extends State<NationalityResidenceScreen> {
  String? _selectedNationality;
  String? _selectedResidence;

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
            onPressed: () {},
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
            StepIndicator(totalSteps: 3, currentStep: 3), // Dynamic Indicator
            SizedBox(height: 32),
            Text(
              'Nationality & Residence',
              style: TextStyle(
                fontSize: FontSizes.f28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Nationality',
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(
                    'Select your nationality',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  value: _selectedNationality,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items:
                      ['Pakistan', 'United States', 'United Kingdom', 'India']
                          .map(
                            (country) => DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            ),
                          )
                          .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedNationality = value),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Country of Residence',
              style: TextStyle(
                fontSize: FontSizes.f14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(
                    'Select your country of residence',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  value: _selectedResidence,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items:
                      ['Pakistan', 'United States', 'United Kingdom', 'India']
                          .map(
                            (country) => DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            ),
                          )
                          .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedResidence = value),
                ),
              ),
            ),
            Spacer(),
            FRectangleButton(
              text: 'Next',
              color: AppColors.blue3,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
