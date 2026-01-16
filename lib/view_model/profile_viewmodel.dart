import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mvtravel/views/auth/signin.dart';
import 'package:mvtravel/views/auth/signup.dart';

class UserProfileViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool isInvestmentUploaded = false;

  // ---------------- BASIC ----------------
  String fullName = "Pending";
  String email = "Pending";
  String birthDate = "Pending";
  String passportNumber = "Pending";
  String nationality = "Pending";
  String phoneNumber = "Pending";
  String offerLetterUrl = "Pending";
  String offerLetterFileName = "Pending";
  // ---------------- PHONE ----------------
  String phoneDialCode = "+92";

  // ---------------- RESIDENCE ----------------
  String residence = "Pending";

  // ---------------- INVESTMENT ----------------
  String investmentAmount = "Pending";
  String investmentType = "Pending";

  // ---------------- WORK ----------------
  String jobTitle = "Pending";
  String experience = "Pending";
  String salary = "Pending";
  bool hasJobOffer = false;

  // ---------------- INVESTMENT ----------------
  String fileName = "";
  String investmentDocUrl = "";
  List<Map<String, String>> investmentDocuments = [];

  // ---------------- TRAVEL ----------------
  String purposeOfTravel = "Pending";
  String visaType = "Pending";
  String travelDates = "Pending";

  // ---------------- DOCUMENTS ----------------
  List<String> uploadedDocs = [];
  String? profileImageUrl; // Firebase Storage URL
  File? profileImageFile; // local picked file
  bool isUploading = false; // loader for profile image

  // ---------------- COMMUNICATION ----------------
  bool emailNotification = false;
  bool smsAlerts = false;
  bool whatsappUpdate = false;

  // ---------------- IMAGE PICKER ----------------
  final ImagePicker _picker = ImagePicker();

  // ---------------- PICK & UPLOAD PROFILE IMAGE ----------------
  Future<void> pickAndUploadProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      profileImageFile = File(pickedFile.path);
      _safeNotify();

      isUploading = true;
      _safeNotify();

      final fileName = 'profile.jpg';
      final ref = FirebaseStorage.instance.ref().child(
        'profile_pictures/${user.uid}/$fileName',
      );

      final snapshot = await ref.putFile(profileImageFile!);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      profileImageUrl = downloadUrl;

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'profileImageUrl': downloadUrl,
      }, SetOptions(merge: true));

      debugPrint('Profile image uploaded: $downloadUrl');
    } catch (e) {
      debugPrint("Error picking/uploading profile image: $e");
    } finally {
      isUploading = false;
      _safeNotify();
      fetchUserProfile(); // refresh profile after upload
    }
  }

  // ---------------- REMOVE PROFILE IMAGE ----------------
  void removeProfileImage() {
    profileImageFile = null;
    profileImageUrl = null;
    _safeNotify();
  }

  // ---------------- FETCH USER PROFILE ----------------
  Future<void> fetchUserProfile() async {
    isLoading = true;
    _safeNotify();

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
      // -------- BASIC --------
      fullName = data['fullName'] ?? fullName;
      email = data['email'] ?? email;
      passportNumber = data['visaPassportNumber'] ?? passportNumber;

      // -------- BIRTH DATE --------
      final birth = data['birthDate'];
      if (birth != null) {
        if (birth is int) {
          birthDate = DateFormat(
            'dd MMM yyyy',
          ).format(DateTime.fromMillisecondsSinceEpoch(birth));
        } else if (birth is Timestamp) {
          birthDate = DateFormat('dd MMM yyyy').format(birth.toDate());
        }
      }

      // -------- PROFILE IMAGE --------
      profileImageUrl = data['profileImageUrl'];

      // -------- PHONE DIAL CODE --------
      phoneDialCode = data['phoneDialcode'] ?? phoneDialCode;
      phoneNumber = data['phoneNumber'] ?? phoneNumber;

      // -------- NATIONALITY & RESIDENCE --------
      if (data['nationality'] != null && data['nationality'] is Map) {
        nationality = data['nationality']['name'] ?? nationality;
      }
      if (data['residence'] != null && data['residence'] is Map) {
        residence = data['residence']['name'] ?? residence;
      }

      // -------- VISIT PURPOSE / VISA TYPE --------
      visaType = data['visaType']?.toString() ?? visaType;
      purposeOfTravel = data['purposeOfTravel'] ?? purposeOfTravel;

      // -------- TRAVEL VISA --------
      final travelVisa = data['travelVisa'];
      if (travelVisa != null && travelVisa is Map) {
        purposeOfTravel = travelVisa['reason'] ?? purposeOfTravel;

        final start = travelVisa['startDate'];
        final end = travelVisa['endDate'];
        if (start is Timestamp && end is Timestamp) {
          final s = DateFormat('dd MMM yyyy').format(start.toDate());
          final e = DateFormat('dd MMM yyyy').format(end.toDate());
          travelDates = "$s - $e";
        }
      }

      // -------- INVESTMENT DETAILS --------
      final investment = data['investmentDetails'];
      if (investment != null) {
        investmentAmount = investment['amount']?.toString() ?? investmentAmount;
        investmentType =
            investment['investmentType']?.toString() ?? investmentType;
        // uploaded documents are already handled in your existing code
      }

      // -------- WORK APPLICATION --------
      final workApp = data['workApplication'];
      if (workApp != null) {
        offerLetterFileName =
            workApp['offerLetterFileName'] ?? offerLetterFileName;
        offerLetterUrl = workApp['offerLetterUrl'] ?? offerLetterUrl;
        jobTitle = workApp['jobTitle'] ?? jobTitle;
        experience = workApp['experience'] ?? experience;
        salary = workApp['salary'] ?? salary;
        hasJobOffer = workApp['hasJobOffer'] ?? hasJobOffer;
      }

      // -------- COMMUNICATION PREFS --------
      final comm = data['communicationPreferences'];
      if (comm != null) {
        emailNotification = comm['email'] ?? emailNotification;
        smsAlerts = comm['sms'] ?? smsAlerts;
        whatsappUpdate = comm['whatsapp'] ?? whatsappUpdate;
      }
    } catch (e) {
      debugPrint("Profile error: $e");
    }

    _finish();
  }

  // ---------------- HELPER: SAFE NOTIFY ----------------
  bool _disposed = false;
  void _safeNotify() {
    if (!_disposed) notifyListeners();
  }

  void _finish() {
    isLoading = false;
    _safeNotify();
  }

  // ---------------- LOGOUT ----------------
  logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    _safeNotify();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
