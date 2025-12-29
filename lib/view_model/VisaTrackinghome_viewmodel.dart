// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import '../model/visa_tracking_model.dart';

// class VisaTHome extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   List<VisaTrackingModel> _applications = [];
//   List<VisaTrackingModel> get applications => _applications;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   VisaTHome() {
//     fetchApplications(); // fetch data when ViewModel is initialized
//   }

//   Future<void> fetchApplications() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final snapshot = await _firestore.collection('visa_tracking').get();

//       _applications = snapshot.docs.map((doc) {
//         final data = doc.data();
//         return VisaTrackingModel(
//           type: data['visaType'] ?? '',
//           status: data['status'] ?? '',
//           country: data['country'] ?? '',
//           createdAt: (data['createdAt'] as Timestamp).toDate(),
//           feeStatus: data['feeStatus'] ?? '',
//           currentStep: data['currentStep'] ?? 0,
//           visaFullName: data['visaFullName'],
//           visaEmail: data['visaEmail'],
//           visaCity: data['visaCity'],
//           visaBirthDate: data['visaBirthDate'],
//         );
//       }).toList();
//     } catch (e) {
//       if (kDebugMode) print('Error fetching visa applications: $e');
//       _applications = [];
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }
