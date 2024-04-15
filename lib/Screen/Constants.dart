import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
class Constants {
  static bool isSPDO = true;

  //Primary color
  static var primaryColor = const Color(0xFF4B4FEE);
  static var primaryColorDarker = const Color(0xFF040658);
  static var primaryColorLighter = const Color(0x95040558);
  static var primaryBgColor = const Color(0xFFE8E9F3);
  static var primaryHoverColor = const Color.fromARGB(175, 75, 78, 238);
  static var primarySelectColor = const Color(0xFF4B4FEE);
  static var blackColor = const Color.fromARGB(199, 175, 175, 175);
  static var backgroundColor = const Color(0xFFFBFBFB);

  //Onboarding texts
  static var title = "Digital NFC Card";
  static var poweredBy = "powered by Garage Atlas";
  static var descriptionOne = "Welcome to the digital NFC card world. We invite you to a sustainable future! Create your card now with a simple, few-step process";
  // static var titleTwo = "Find a plant lover friend";
  static var descriptionTwo = "With this created NFC card, you can effortlessly carry out transactions and save time effectively";
  // static var titleThree = "Plant a tree, green the Earth";
  static var descriptionThree = "Privacy and security are our top priorities. When using our NFC card application, our users' personal information is kept confidential with strong encryption methods.";

  static var baseProfileUrl = "https://ugur.atlas.space/#/users/";

  static int responsiveFlex(double width) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.width;

    if (width < 610) {
      return 0;
    } else if (610 < width)
      return 1;
    else
      return 2;
  }

  

  // To show user popup.
  static SnackBar SnackBarWidget(SnackBarType snackBarType, String message) {
    return SnackBar(
      padding: const EdgeInsets.all(0),
      content: Row(
        children: [
          Container(
            width: 10,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              ),
              color: snackBarType == SnackBarType.success
                  ? const Color(0xFF34A853)
                  : const Color(0xFFA84834), // Green color for the left border
            ),
          ),
          const SizedBox( width: 15.0),
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF191919),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          snackBarType == SnackBarType.success
              ?  Image.asset(
                  "assets/images/tick.png",
                  width: 20,
              )
              : const Icon(
                  Icons.error_rounded,
                  size: 20,
                  color: Color(0xFFA84834),
                ),
          const SizedBox( width: 15.0)
        ],
      ),
      margin: const EdgeInsets.only(bottom: 130.0, left: 30.0, right: 30.0),
      backgroundColor: const Color(0xFCFCFCFC),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    );
  }

  static void setTheme(String themeName) {
    print("Theme Name: $themeName");
    switch (themeName) {
      case "defaultTheme":
        // _themeType = ThemeType.defaultTheme;
        primaryColor = const Color(0xFF4B4FEE);
        primaryColorDarker = const Color(0xFF040658);
        primaryColorLighter = const Color(0x95040558);
        primaryBgColor = const Color(0xFFE8E9F3);
        break;
      case "spdoRedTheme":
        // _themeType = ThemeType.spdoRedTheme;
        primaryColor = const Color(0xFFBB1C2F);
        primaryColorDarker = const Color(0xFF894C4D);
        primaryColorLighter = const Color(0x94894C4D);
        primaryBgColor = const Color(0xFFF7E5E5);
        break;
      case "spdoYellowTheme":
        // _themeType = ThemeType.spdoYellowTheme;
        primaryColor = const Color.fromARGB(255, 184, 187, 28);
        primaryColorDarker = const Color.fromARGB(255, 137, 133, 76);
        primaryColorLighter = const Color.fromARGB(147, 137, 130, 76);
        primaryBgColor = const Color.fromARGB(255, 247, 247, 229);
        break;
      default:
        // do something
        primaryColor = const Color(0xFF4B4FEE);
        primaryColorDarker = const Color(0xFF040658);
        primaryColorLighter = const Color(0x95040558);
        primaryBgColor = const Color(0xFFE8E9F3);
        break;
    }
  }
}

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

enum ThemeType {
  defaultTheme,
  spdoRedTheme,
  spdoYellowTheme,
}