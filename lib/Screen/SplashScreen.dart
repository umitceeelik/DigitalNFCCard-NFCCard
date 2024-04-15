// ignore_for_file: use_build_context_synchronously

import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Login/LoginScreen.dart';
import 'package:digital_nfc_card/Screen/OnboardingScreen/OnboardingScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/ProfileScreen.dart';
import 'package:digital_nfc_card/Services/AuthService.dart';
import 'package:digital_nfc_card/Services/LoadingIndicator.dart';
import 'package:digital_nfc_card/Services/TokenStorageService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showOnboarding = true;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if onboarding has been shown
    bool onboardingShown = prefs.getBool('onboarding_shown') ?? false;

    // Check if the user has a valid token
    String? token = await TokenStorageService.getToken();
    print("Token = $token");
    setState(() {
      _showOnboarding = !onboardingShown;
    });

    if (_showOnboarding && token == null) {
      // If onboarding hasn't been shown, navigate to onboarding screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else if (token != null && token.isNotEmpty) {
      try {
        LoadingIndicator.showLoadingIndicator(context);
        await AuthService.fetchDataFromAws(context, null);
        var userDataProvider =
            Provider.of<UserDataProvider>(context, listen: false);
        // If the user has a token, navigate to your main screen
        if (userDataProvider.userDataList.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        } else {
          await TokenStorageService.deleteToken();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ProfileScreen()),
        // );
      } catch (e) {
        print(e.toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } finally {
        LoadingIndicator.hideLoadingIndicator();
      }
      // await AuthService.fetchDataFromAws(context);
      // // If the user has a token, navigate to your main screen
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const ProfileScreen()),
      // );
    } else {
      // If onboarding has been shown, navigate to your main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // You can show a splash screen here if needed
    return Container();
  }
}
