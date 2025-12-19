import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/colors.dart';

class Documents extends StatelessWidget {
  const Documents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Center(
          child: Text(
            'firestore storage is pending for setup ',
            style: TextStyle(fontSize: 15, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
