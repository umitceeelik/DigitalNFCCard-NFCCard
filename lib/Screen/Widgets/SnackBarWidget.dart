// import 'package:digital_nfc_card/Screen/Constants.dart';
// import 'package:flutter/material.dart';

// class SnackBarWidget extends StatelessWidget {
//   final BuildContext context;
//   final String message;
//   final SnackBarType snackBarType;

//   const SnackBarWidget({
//     Key? key,
//     required this.context,
//     required this.message,
//     required this.snackBarType,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
//       content: Text(
//         message,
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//           fontSize: 18,
//           fontFamily: 'Montserrat',
//           fontWeight: FontWeight.w600,
//           height: 0,
//         ),
//       ),
//       margin: const EdgeInsets.only(bottom: 150.0, left: 50.0, right: 50.0),
//       backgroundColor: snackBarType == SnackBarType.success
//           ? const Color.fromARGB(204, 50, 156, 45)
//           : const Color.fromARGB(204, 230, 62, 50),
//       behavior: SnackBarBehavior.floating,
//       duration: const Duration(seconds: 1),
//     );
//   }
// }


