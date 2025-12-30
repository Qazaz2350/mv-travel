import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/visa_tracking_model.dart';

class VisaTrackingViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  List<VisaTrackingModel> applications = [];
  bool isLoading = false;

  int get totalResults => applications.length;

  // Constructor
  VisaTrackingViewModel() {
    fetchVisas(); // constructor ka call same rakha
  }

  Future<void> fetchVisas() async {
    isLoading = true;
    notifyListeners();

    // Clear existing data
    applications.clear();

    // Firestore snapshots stream se listen karein
    _firestore
        .collection('users')
        .doc(uid)
        .collection('visas')
        .snapshots()
        .listen((snapshot) {
          applications = snapshot.docs
              .map((doc) => VisaTrackingModel.fromFirestore(doc.data()))
              .toList();

          isLoading = false;
          notifyListeners();
        });
  }
}
