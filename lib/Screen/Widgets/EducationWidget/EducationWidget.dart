import 'package:digital_nfc_card/Screen/Widgets/TextFormFieldWidget.dart';
import 'package:flutter/material.dart';

class EducationWidget extends StatelessWidget {
  final TextEditingController schoolController;
  final TextEditingController degreeController;
  final TextEditingController fieldOfStudyController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  const EducationWidget({
    super.key,
    required this.schoolController,
    required this.degreeController,
    required this.fieldOfStudyController,
    required this.startDateController,
    required this.endDateController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormFieldWidget(
          option: "School(*)",
          hintText: "School",
          textEditingController: schoolController,
          textInputType: TextInputType.name,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "School can not be empty.";
            }
            return null;
          },
        ),
        TextFormFieldWidget(
          option: "Degree(*)",
          hintText: "Enter your degree",
          textEditingController: degreeController,
          textInputType: TextInputType.name,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Degree can not be empty.";
            }
            return null;
          },
        ),
        TextFormFieldWidget(
          option: "Field Of Study(*)",
          hintText: "Enter your department",
          textEditingController: fieldOfStudyController,
          textInputType: TextInputType.name,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Field Of Study can not be empty.";
            }
            return null;
          },
        ),
        TextFormFieldWidget(
          option: "Starting Date",
          hintText: "Date (DD/MM/YYYY)",
          textEditingController: startDateController,
          textInputType: TextInputType.datetime,
          isDateField: true,
        ),
        TextFormFieldWidget(
          option: "Ending Date",
          hintText: "Date (DD/MM/YYYY)",
          textEditingController: endDateController,
          textInputType: TextInputType.datetime,
          isDateField: true,
        ),
      ],
    );
  }
}
