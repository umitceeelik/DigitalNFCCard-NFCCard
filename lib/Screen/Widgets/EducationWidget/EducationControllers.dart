import 'package:flutter/material.dart';

class EducationControllers {
  final TextEditingController school;
  final TextEditingController degree;
  final TextEditingController fieldOfStudy;
  final TextEditingController startDate;
  final TextEditingController endDate;

  EducationControllers({
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
  });
}