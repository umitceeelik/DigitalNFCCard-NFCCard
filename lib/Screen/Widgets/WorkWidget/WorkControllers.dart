import 'package:flutter/material.dart';

class WorkControllers {
  final TextEditingController companyName;
  final TextEditingController jobTitle;
  final TextEditingController taxID;
  final TextEditingController iban;

  WorkControllers({
    required this.companyName,
    required this.jobTitle,
    required this.taxID,
    required this.iban,
  });
}