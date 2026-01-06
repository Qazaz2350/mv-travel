// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mvtravel/model/profile_image_model.dart';
// import 'package:mvtravel/view_model/profile_viewmodel.dart';
// import 'package:provider/provider.dart';

// class ProfileImageViewModel extends ChangeNotifier {
//   final ImagePicker _picker = ImagePicker();
//   ProfileImageModel _model = ProfileImageModel();

//   // ---------------- State ----------------
//   bool _disposed = false; // to prevent notifyListeners after dispose
//   bool isUploading = false; // for showing loader in UI

//   // ---------------- Getters ----------------
//   File? get profileImage => _model.profileImage;
//   String? get profileImageUrl => _model.profileImageUrl;

//   // ---------------- Dispose-safe ----------------
//   @override
//   void dispose() {
//     _disposed = true;
//     super.dispose();
//   }

//   @override
//   void notifyListeners() {
//     if (!_disposed) super.notifyListeners();
//   }

//   // ---------------- Pick & Upload Image ----------------
//   Future<void> pickImageFromGallery(BuildContext context) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         debugPrint("User not logged in, cannot upload profile image.");
//         return;
//       }

//       final pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 85,
//       );

//       if (pickedFile == null) return; // user cancelled

//       File imageFile = File(pickedFile.path);
//       _model.profileImage = imageFile;

//       // Start uploading
//       isUploading = true;
//       notifyListeners();

//       // Upload to Firebase Storage
//       String fileName = 'profile.jpg';
//       Reference ref = FirebaseStorage.instance.ref().child(
//         'profile_pictures/${user.uid}/$fileName',
//       );

//       UploadTask uploadTask = ref.putFile(imageFile);
//       TaskSnapshot snapshot = await uploadTask;

//       // Get download URL
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//       _model.profileImageUrl = downloadUrl;

//       // Save URL to Firestore (merge with existing data)
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'profileImageUrl': downloadUrl,
//       }, SetOptions(merge: true));

//       debugPrint('Profile image uploaded: $downloadUrl');
//     } catch (e) {
//       debugPrint('Error picking/uploading profile image: $e');
//     } finally {
//       isUploading = false;
//       notifyListeners();
//       final profileVM = context.read<UserProfileViewModel>();
//       profileVM.fetchUserProfile();
//     }
//   }

//   // ---------------- Remove Image ----------------
//   void removeImage() {
//     _model.profileImage = null;
//     _model.profileImageUrl = null;
//     notifyListeners();
//   }
// }
