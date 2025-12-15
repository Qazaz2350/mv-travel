// import 'package:flutter/material.dart';

class InternationalStudentsModel {
  String universityName;
  String admissionStatus; // Accepted, Pending, Applied
  String studyLevel; // Undergraduate, Graduate, etc.

  InternationalStudentsModel({
    this.universityName = '',
    this.admissionStatus = 'Accepted',
    this.studyLevel = 'Undergraduate',
  });
}
