import 'dart:io';

class ProfileImageModel {
  File? profileImage; // Local file picked from gallery
  String? profileImageUrl; // ✅ Firebase Storage download URL

  ProfileImageModel({this.profileImage, this.profileImageUrl});
}
