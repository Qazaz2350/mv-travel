import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/commen/full_size_button.dart';
import 'package:mvtravel/utilis/commen/progress_indicator.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/views/user_verification/nationality_residence.dart';

class BirthDateScreen extends StatefulWidget {
  const BirthDateScreen({Key? key}) : super(key: key);

  @override
  State<BirthDateScreen> createState() => _BirthDateScreenState();
}

class _BirthDateScreenState extends State<BirthDateScreen> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: ColorScheme.light(primary: AppColors.blue1)),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MM / dd / yyyy').format(picked);
      });
    }
  }

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
            onPressed: () => Nav.push(context, NationalityResidenceScreen()),
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
            StepIndicator(totalSteps: 3, currentStep: 2), // Dynamic Indicator
            SizedBox(height: 32),
            Text(
              'Select your Birth Date',
              style: TextStyle(
                fontSize: FontSizes.f28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 12),
                    Text(
                      _dateController.text.isEmpty
                          ? 'mm / dd / yyyy'
                          : _dateController.text,
                      style: TextStyle(
                        fontSize: FontSizes.f16,
                        color: _dateController.text.isEmpty
                            ? Colors.grey[400]
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            FRectangleButton(
              text: 'Next',
              color: AppColors.blue3,
              onPressed: () => Nav.push(context, NationalityResidenceScreen()),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
