import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvtravel/model/profile_image_model.dart';

class ProfileImageViewModel extends ChangeNotifier {
  ProfileImageModel _model = ProfileImageModel();
  final ImagePicker _picker = ImagePicker();

  File? get profileImage => _model.profileImage;

  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        _model.profileImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void removeImage() {
    _model.profileImage = null;
    notifyListeners();
  }
}
