// import 'package:flutter/material.dart';
// import 'package:mvtravel/model/application_status_model.dart';
// import 'package:mvtravel/model/visa_tracking_model.dart';
// // import 'application_status_model.dart';

// class ApplicationStatusViewModel extends ChangeNotifier {
//   late ApplicationStatusModel _application;

//   ApplicationStatusViewModel() {
//     // Example initialization (replace with real data)
//     _application = ApplicationStatusModel(
//       visaType: 'Travel Visa',
//       processingTime: '15 - 20 Days',
//       submissionId: 'TRV-44984984',
//       isPaid: true,
//       passportCompleted: true,
//       cnicCompleted: true,
//       photoCompleted: true,
//       travelVisaRequired: true,
      
//     );
//   }

//   ApplicationStatusModel get application => _application;

//   String getPassportStatus() =>
//       _application.passportCompleted ? 'Completed' : 'Required';
//   String getCnicStatus() =>
//       _application.cnicCompleted ? 'Completed' : 'Required';
//   String getPhotoStatus() =>
//       _application.photoCompleted ? 'Completed' : 'Required';
//   String getPaymentStatus() => _application.isPaid ? 'Paid' : 'Pending';
// }
