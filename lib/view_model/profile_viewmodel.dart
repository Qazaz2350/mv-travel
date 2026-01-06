// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:mvtravel/utilis/nav.dart';
// import 'package:mvtravel/views/auth/signin.dart';

// class UserProfileViewModel extends ChangeNotifier {
//   bool isLoading = false;
//   bool isInvestmentUploaded = false;

//   // ---------------- BASIC ----------------
//   String fullName = "Pending";
//   String email = "Pending";
//   String birthDate = "Pending";
//   String passportNumber = "Pending";
//   String nationality = "Pending";
//   String phoneNumber = "Pending";
//   String offerLetterUrl = "Pending";
//   String offerLetterFileName = "Pending";

//   // ---------------- INVESTMENT ----------------
//   String fileName = "";
//   String investmentDocUrl = "";
//   List<Map<String, String>> investmentDocuments = []; // <-- NEW

//   // ---------------- TRAVEL ----------------
//   String purposeOfTravel = "Pending";
//   String visaType = "Pending";
//   String travelDates = "Pending";

//   // ---------------- DOCUMENTS ----------------
//   List<String> uploadedDocs = [];
//   String? profileImageUrl; // ✅ Firebase Storage URL

//   // ---------------- COMMUNICATION ----------------
//   bool emailNotification = false;
//   bool smsAlerts = false;
//   bool whatsappUpdate = false;

//   // ---------------- IMAGE PICKER ----------------
//   final ImagePicker _picker = ImagePicker();
//   File? profileImageFile; // local picked file

//   Future<void> pickAndUploadProfileImage() async {
//     try {
//       // Check if user is logged in
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         debugPrint("User not logged in, cannot upload profile image.");
//         return;
//       }

//       // Pick image
//       final pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 85,
//       );

//       if (pickedFile == null) return; // user cancelled

//       // Save locally
//       profileImageFile = File(pickedFile.path);
//       debugPrint('Profile image picked: ${profileImageFile!.path}');
//       _safeNotify();

//       // Start uploading
//       isLoading = true; // optional: show loader
//       _safeNotify();

//       // Upload to Firebase Storage
//       final fileName = 'profile.jpg';
//       final ref = FirebaseStorage.instance.ref().child(
//         'profile_pictures/${user.uid}/$fileName',
//       );

//       final snapshot = await ref.putFile(profileImageFile!);

//       // Get download URL
//       final downloadUrl = await snapshot.ref.getDownloadURL();

//       // Update Firestore
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'profileImageUrl': downloadUrl,
//       }, SetOptions(merge: true));

//       profileImageUrl = downloadUrl;
//       debugPrint('Profile image uploaded/updated: $downloadUrl');
//     } catch (e) {
//       debugPrint("Error picking/uploading profile image: $e");
//     } finally {
//       isLoading = false;
//       _safeNotify();
//     }
//   }

//   // ---------------- Helper: dispose-safe notify ----------------
//   bool _disposed = false;
//   void _safeNotify() {
//     if (!_disposed) notifyListeners();
//   }

//   @override
//   void dispose() {
//     _disposed = true;
//     super.dispose();
//   }

//   // ---------------- FETCH USER PROFILE ----------------
//   Future<void> fetchUserProfile() async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;

//       final doc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       if (!doc.exists) {
//         _finish();
//         return;
//       }

//       final data = doc.data()!;

//       // -------- BASIC --------
//       fullName = data['fullName'] ?? fullName;
//       email = data['email'] ?? email;
//       nationality = data['nationality'] ?? nationality;
//       phoneNumber = data['phoneNumber'] ?? phoneNumber;
//       passportNumber = data['visaPassportNumber'] ?? passportNumber;

//       // -------- BIRTH DATE --------
//       if (data['birthDate'] != null && data['birthDate'] is int) {
//         final date = DateTime.fromMillisecondsSinceEpoch(data['birthDate']);
//         birthDate = DateFormat('dd MMM yyyy').format(date);
//       }

//       // -------- PROFILE IMAGE --------
//       profileImageUrl = data['profileImageUrl'];

//       // -------- OFFER LETTER --------
//       final workApp = data['workApplication'];
//       if (workApp != null) {
//         offerLetterFileName =
//             workApp['offerLetterFileName'] ?? offerLetterFileName;
//         offerLetterUrl = workApp['offerLetterUrl'] ?? offerLetterUrl;
//       }

//       // -------- INVESTMENT DOCUMENTS --------
//       investmentDocuments = [];
//       if (data['uploadedDocuments'] is List &&
//           data['uploadedDocuments'].isNotEmpty) {
//         investmentDocuments = (data['uploadedDocuments'] as List)
//             .map<Map<String, String>>(
//               (doc) => {
//                 'fileUrl': doc['fileUrl'] ?? "",
//                 'investmentDocument': doc['investmentDocument'] ?? "",
//               },
//             )
//             .toList();

//         isInvestmentUploaded = investmentDocuments.isNotEmpty;

//         if (investmentDocuments.isNotEmpty) {
//           investmentDocUrl = investmentDocuments[0]['fileUrl']!;
//           fileName = investmentDocuments[0]['investmentDocument']!;
//         }
//       } else {
//         investmentDocUrl = "";
//         fileName = "";
//         isInvestmentUploaded = false;
//       }

//       // -------- TRAVEL VISA --------
//       final travelVisa = data['travelVisa'];
//       if (travelVisa != null) {
//         purposeOfTravel = travelVisa['reason'] ?? purposeOfTravel;
//         visaType = (travelVisa['visaType'] ?? visaType).toString();

//         final start = travelVisa['startDate'];
//         final end = travelVisa['endDate'];
//         if (start is Timestamp && end is Timestamp) {
//           final s = DateFormat('dd MMM yyyy').format(start.toDate());
//           final e = DateFormat('dd MMM yyyy').format(end.toDate());
//           travelDates = "$s - $e";
//         }
//       } else {
//         visaType = data['selectedPurpose'] ?? visaType;
//         purposeOfTravel = data['purposeOfTravel'] ?? purposeOfTravel;
//       }

//       // -------- OTHER DOCUMENTS --------
//       // if (data['uploadedDocs'] is List) {
//       //   uploadedDocs = List<String>.from(data['uploadedDocs']);
//       // }

//       // -------- COMMUNICATION PREFS --------
//       final comm = data['communicationPreferences'];
//       if (comm != null) {
//         emailNotification = comm['email'] ?? emailNotification;
//         smsAlerts = comm['sms'] ?? smsAlerts;
//         whatsappUpdate = comm['whatsapp'] ?? whatsappUpdate;
//       }
//     } catch (e) {
//       debugPrint("Profile error: $e");
//     }

//     _finish();
//   }

//   // ---------------- FINISH ----------------
//   void _finish() {
//     isLoading = false;
//     notifyListeners();
//   }

//   // ---------------- LOGOUT ----------------
//   logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     notifyListeners();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => SignInScreen()),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/views/auth/signin.dart';

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
      fullName = data['fullName'] ?? fullName;
      email = data['email'] ?? email;
      nationality = data['nationality'] ?? nationality;
      phoneNumber = data['phoneNumber'] ?? phoneNumber;
      passportNumber = data['visaPassportNumber'] ?? passportNumber;

      // -------- BIRTH DATE --------
      if (data['birthDate'] != null && data['birthDate'] is int) {
        final date = DateTime.fromMillisecondsSinceEpoch(data['birthDate']);
        birthDate = DateFormat('dd MMM yyyy').format(date);
      }

      // -------- PROFILE IMAGE --------
      profileImageUrl = data['profileImageUrl'];

      // -------- OFFER LETTER --------
      final workApp = data['workApplication'];
      if (workApp != null) {
        offerLetterFileName =
            workApp['offerLetterFileName'] ?? offerLetterFileName;
        offerLetterUrl = workApp['offerLetterUrl'] ?? offerLetterUrl;
      }

      // -------- INVESTMENT DOCUMENTS --------
      investmentDocuments = [];
      if (data['uploadedDocuments'] is List &&
          data['uploadedDocuments'].isNotEmpty) {
        investmentDocuments = (data['uploadedDocuments'] as List)
            .map<Map<String, String>>(
              (doc) => {
                'fileUrl': doc['fileUrl'] ?? "",
                'investmentDocument': doc['investmentDocument'] ?? "",
              },
            )
            .toList();

        isInvestmentUploaded = investmentDocuments.isNotEmpty;

        if (investmentDocuments.isNotEmpty) {
          investmentDocUrl = investmentDocuments[0]['fileUrl']!;
          fileName = investmentDocuments[0]['investmentDocument']!;
        }
      } else {
        investmentDocUrl = "";
        fileName = "";
        isInvestmentUploaded = false;
      }

      // -------- TRAVEL VISA --------
      final travelVisa = data['travelVisa'];
      if (travelVisa != null) {
        purposeOfTravel = travelVisa['reason'] ?? purposeOfTravel;
        visaType = (travelVisa['visaType'] ?? visaType).toString();

        final start = travelVisa['startDate'];
        final end = travelVisa['endDate'];
        if (start is Timestamp && end is Timestamp) {
          final s = DateFormat('dd MMM yyyy').format(start.toDate());
          final e = DateFormat('dd MMM yyyy').format(end.toDate());
          travelDates = "$s - $e";
        }
      } else {
        visaType = data['selectedPurpose'] ?? visaType;
        purposeOfTravel = data['purposeOfTravel'] ?? purposeOfTravel;
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
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
