import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/views/whastapp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/views/home/callView.dart';

class FloatingButtonsWidget extends StatelessWidget {
  const FloatingButtonsWidget({super.key});

  Future<void> openWhatsApp() async {
    const phoneNumber = "923281223062"; // NO +
    final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber");

    await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          shape: const CircleBorder(),
          heroTag: 'phone',
          onPressed: () {
            Nav.push(context, ContactProfileScreen());
          },
          backgroundColor: AppColors.blue1,
          child: const Icon(Icons.phone, color: Colors.white),
        ),

        SizedBox(height: 12.h),

        FloatingActionButton(
          shape: const CircleBorder(),
          heroTag: 'chat2',
          onPressed: openWhatsApp, // ✅ FIXED
          backgroundColor: const Color(0xff31ab20),
          child: Image.asset("assets/home/whatsapp.png", height: 30.h),
        ),

        SizedBox(height: 100.h),
      ],
    );
  }
}
