import 'package:digital_nfc_card/Screen/Widgets/TextFormFieldWidget.dart';
import 'package:flutter/material.dart';

class WorkWidget extends StatelessWidget {
  final TextEditingController companyNameController;
  final TextEditingController jobTitleController;
  final TextEditingController taxIDController;
  final TextEditingController ibanController;

  const WorkWidget({
    super.key,
    required this.companyNameController,
    required this.jobTitleController,
    required this.taxIDController,
    required this.ibanController
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormFieldWidget(
          option:"Company Name(*)",
          hintText: "Enter your company name",
          textEditingController: companyNameController, 
          textInputType: TextInputType.name,
          validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Company name can not be empty.";
                }
                return null;
              },),
        TextFormFieldWidget(
          option:"Job Title(*)",
          hintText: "Enter your job title",
          textEditingController: jobTitleController, 
          textInputType: TextInputType.name,
          validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Job title can not be empty.";
                }
                return null;
              },),
        TextFormFieldWidget(
          option:"Tax ID",
          hintText: "Enter your tax ID",
          textEditingController: taxIDController, 
          textInputType: TextInputType.name),
        TextFormFieldWidget(
          option:"IBAN",
          hintText: "Enter your IBAN",
          textEditingController: ibanController, 
          textInputType: TextInputType.text),
      ],
    );
  }
}