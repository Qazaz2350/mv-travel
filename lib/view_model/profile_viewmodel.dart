import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfileViewModel extends ChangeNotifier {
  bool isLoading = false;

  // ---------------- BASIC ----------------
  String fullName = "Pending";
  String email = "Pending";
  String birthDate = "Pending";
  String passportNumber = "Pending";
  String nationality = "Pending";
  String phoneNumber = "Pending";

  // ---------------- TRAVEL ----------------
  String purposeOfTravel = "Pending";
  String visaType = "Pending";
  String travelDates = "Pending";

  // ---------------- DOCUMENTS ----------------
  List<String> uploadedDocs = [];

  // ---------------- COMMUNICATION ----------------
  bool emailNotification = false;
  bool smsAlerts = false;
  bool whatsappUpdate = false;

  // ---------------- FETCH PROFILE ----------------
  Future<void> fetchUserProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        _finish();
        return;
      }

      final data = doc.data()!;

      // -------- BASIC --------
      fullName = data['fullName'] ?? "Pending";
      email = data['email'] ?? "Pending";
      nationality = data['nationality'] ?? "Pending";
      visaType = data['visaType'] ?? "Pending";

      phoneNumber = data['phoneNumber'] ?? "Pending";
      passportNumber = data['visaPassportNumber'] ?? "Pending";

      // -------- BIRTH DATE (number → string) --------
      if (data['birthDate'] != null && data['birthDate'] is int) {
        final date = DateTime.fromMillisecondsSinceEpoch(data['birthDate']);
        birthDate = DateFormat('dd MMM yyyy').format(date);
      }

      // -------- TRAVEL VISA --------
      final travelVisa = data['travelVisa'];
      if (travelVisa != null) {
        purposeOfTravel = travelVisa['reason'] ?? purposeOfTravel;

        // Only override visaType if it exists, otherwise keep data['visaType'] or "Pending"
        if (travelVisa['visaType'] != null &&
            travelVisa['visaType'].toString().isNotEmpty) {
          visaType = travelVisa['visaType'];
        }

        final start = travelVisa['startDate'];
        final end = travelVisa['endDate'];
        if (start is Timestamp && end is Timestamp) {
          final s = DateFormat('dd MMM yyyy').format(start.toDate());
          final e = DateFormat('dd MMM yyyy').format(end.toDate());
          travelDates = "$s - $e";
        }
      } else {
        // If no travelVisa map exists, fallback to basic data
        visaType = data['visaType'] ?? visaType;
        purposeOfTravel = data['purposeOfTravel'] ?? purposeOfTravel;
      }

      // -------- DOCUMENTS --------
      if (data['uploadedDocs'] is List) {
        uploadedDocs = List<String>.from(data['uploadedDocs']);
      }

      // -------- COMMUNICATION PREFS --------
      final comm = data['communicationPreferences'];
      if (comm != null) {
        emailNotification = comm['email'] ?? false;
        smsAlerts = comm['sms'] ?? false;
        whatsappUpdate = comm['whatsapp'] ?? false;
      }
    } catch (e) {
      debugPrint("Profile error: $e");
    }

    _finish();
  }

  void _finish() {
    isLoading = false;
    notifyListeners();
  }
}
