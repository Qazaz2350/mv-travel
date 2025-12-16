import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvtravel/model/apply_process_model.dart';

class ApplyProcessViewModel extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  final ApplyProcessModel model = ApplyProcessModel();

  int get currentStep => model.currentStep;
  File? get photoFile => model.photoFile;
  File? get passportFile => model.passportFile;

  void nextStep() {
    if (model.currentStep < 3) {
      model.currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (model.currentStep > 0) {
      model.currentStep--;
      notifyListeners();
    }
  }

  void removePhoto() {
    model.photoFile = null;
    notifyListeners();
  }

  void removePassport() {
    model.passportFile = null;
    notifyListeners();
  }

  Future<void> pickFromGallery(bool isPhoto) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (isPhoto) {
        model.photoFile = File(image.path);
      } else {
        model.passportFile = File(image.path);
      }
      notifyListeners();
    }
  }

  Future<void> pickFromCamera(bool isPhoto) async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (isPhoto) {
        model.photoFile = File(image.path);
      } else {
        model.passportFile = File(image.path);
      }
      notifyListeners();
    }
  }
}
