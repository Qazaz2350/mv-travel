// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/visa_tracking_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class VisaTrackingViewModel extends ChangeNotifier {
//   List<VisaTrackingModel> applications = [];
//   int totalResults = 0;
//   bool isLoading = false;

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> fetchApplications() async {
//     try {
//       isLoading = true;
//       notifyListeners();

//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;

//       final snapshot = await _firestore
//           .collection('users')
//           .doc(user.uid)
//           .collection('visas')
//           .get();

//       applications = snapshot.docs.map((doc) {
//         final data = doc.data();
//         return VisaTrackingModel(
//           type: data['type'] ?? '',
//           status: data['status'] ?? '',
//           country: data['country'] ?? '',
//           // city: data['city'] ?? '',
//           createdAt: data['createdAt'] ?? '',

//           feeStatus: data['feeStatus'] ?? '',
//           currentStep: data['currentStep'] ?? 0,
//           visaFullName: data['visaFullName'],
//           visaEmail: data['visaEmail'],
//           visaCity: data['visaCity'],
//           visaBirthDate: data['visaBirthDate'],
//           visaNationality: data['visaNationality'],
//           visaNumber: data['visaNumber'],
//           visaPassportNumber: data['visaPassportNumber'],
//           addressForVisa: data['addressForVisa'],
//         );
//       }).toList();

//       totalResults = applications.length;
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       print("Error fetching visas: $e");
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
