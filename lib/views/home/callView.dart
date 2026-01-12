// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class WhatsAppButton extends StatelessWidget {
//   final String phoneNumber = "923281223062"; // Pakistan code + number without leading 0

//   void openWhatsApp() async {
//     final whatsappUrl = "https://wa.me/$phoneNumber";

//     if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
//       await launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint("WhatsApp not installed or cannot open link.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.chat),
//       onPressed: openWhatsApp,
//       color: Colors.green,
//     );
//   }
// }
