import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final DateTime datePickerStart = DateTime(1900);
  final DateTime datePickerEnd = DateTime(
      DateTime.now().year + 3, DateTime.now().month, DateTime.now().day);

  final String option;
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Widget? suffixIcon;
  final bool isDateField;

  TextFormFieldWidget({
    super.key,
    required this.option,
    required this.hintText,
    required this.textEditingController,
    required this.textInputType,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.isDateField = false,
  });

  Widget _getTextFormWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              option,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Constants.primaryColorDarker,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                height: 0.09,
                letterSpacing: 0.02,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: textEditingController,
              obscureText: obscureText ?? false,
              keyboardType: textInputType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0x7F040658),
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.8,
                    strokeAlign: BorderSide.strokeAlignInside,
                    color: Constants.primaryColorDarker,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.8,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Constants.primaryColorDarker,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              // onEditingComplete: () => _focusNodePassword.requestFocus(),
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !isDateField
        ? _getTextFormWidget()
        : GestureDetector(
            child: AbsorbPointer(child: _getTextFormWidget()),
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                firstDate: datePickerStart,
                lastDate: datePickerEnd,
                initialDate: DateTime.now(),
              );
              if (pickedDate != null) {
                textEditingController.value = TextEditingValue(
                    text:
                        ("${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"));
              } else {
                textEditingController.value = const TextEditingValue(text: "");
              }
            });
  }
}
