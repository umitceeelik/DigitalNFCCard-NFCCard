import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:digital_nfc_card/Screen/SplashScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      title: 'Splash Screen',
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}