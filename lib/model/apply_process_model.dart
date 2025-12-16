import 'dart:io';

class ApplyProcessModel {
  int currentStep;
  File? photoFile;
  File? passportFile;

  ApplyProcessModel({this.currentStep = 0, this.photoFile, this.passportFile});
}
