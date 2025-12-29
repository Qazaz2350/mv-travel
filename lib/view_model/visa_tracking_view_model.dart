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
    fetchVisas();
  }

  Future<void> fetchVisas() async {
    isLoading = true;
    notifyListeners();

    applications.clear();

    final visaDocs = await _firestore
        .collection('users')
        .doc(uid)
        .collection('visas') // <-- directly fetch the same collection
        .get();

    for (var doc in visaDocs.docs) {
      applications.add(VisaTrackingModel.fromFirestore(doc.data()));
    }

    isLoading = false;
    notifyListeners();
  }
}
