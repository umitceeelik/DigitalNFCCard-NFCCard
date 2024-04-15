import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Login/LoginScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/ProfileScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsAccountSettingsScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsDigitalNFCCardProductsScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsLinksScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsPrivacySecurityScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsProfileScreen.dart';
import 'package:digital_nfc_card/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreennState();
}

class _SettingsScreennState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double appBarHeightMultiplier = 0.07;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    EdgeInsets padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight *
            appBarHeightMultiplier), // Adjust the height as needed
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(
                top: 15,
                left: Constants.responsiveFlex(screenWidth) > 0
                    ? 15 + screenWidth / 7
                    : 15,
                right: Constants.responsiveFlex(screenWidth) > 0
                    ? 15 + screenWidth / 7
                    : 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ProfileScreen();
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 26,
                    color: Constants.primaryColorDarker,
                  ),
                ),
                const Text(
                  'Settings',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 42,
                )
              ],
            ),
          ),
          titleTextStyle: TextStyle(
            color: Constants.primaryColorDarker,
            fontSize: Constants.responsiveFlex(screenWidth) > 0 ? 30 : 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
          elevation: 0.0,
          backgroundColor: Constants.backgroundColor,
          surfaceTintColor: Constants.backgroundColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                flex: Constants.responsiveFlex(screenWidth),
                child: Container(
                    alignment: Alignment.center,
                    color: Constants.backgroundColor)),
            Expanded(
              flex: 5,
              child: SizedBox(
                width: screenWidth,
                height:
                    screenHeight - screenHeight * appBarHeightMultiplier - padding.top - padding.bottom,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 32.0,
                    right: 32.0,
                    top: Constants.responsiveFlex(
                                MediaQuery.of(context).size.width) >
                            0
                        ? 60
                        : 40,
                    // bottom: Constants.responsiveFlex(
                    //             MediaQuery.of(context).size.width) >
                    //         0
                    //     ? 60
                    //     : 48
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsButton("Profile", Icons.person_rounded, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SettingsProfileScreen();
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      SettingsButton("Links", Icons.link_rounded, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SettingsLinksScreen();
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      SettingsButton("Account Settings", Icons.key_rounded, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SettingsAccountSettingsScreen();
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      SettingsButton("My Digital NFC Card Products", Icons.nfc_rounded, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SettingsDigitalNFCCardProductsScreen();
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      SettingsButton("Privacy & Security", Icons.privacy_tip_rounded, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SettingsPrivacySecurityScreen();
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      SettingsButton("Sign Out", Icons.exit_to_app_rounded,
                          () async {
                        await AuthService.logOut().then((value) {
                          var userDataProvider =
                              Provider.of<UserDataProvider>(context,
                                  listen: false);
                          userDataProvider.clearUserDataList();
                          userDataProvider.isCreatingFirstCard = false;
                          userDataProvider.isCreatingMoreCards = false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginScreen();
                              },
                            ),
                          );
                        });
                        // context.go('/login');
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: Constants.responsiveFlex(screenWidth),
                child: Container(
                    alignment: Alignment.center,
                    color: Constants.backgroundColor)),
          ],
        ),
      ),
    );
  }

  Widget SettingsButton(String text, IconData iconData, Function() function)
  {
    return TextButton(
        onPressed: () {function();},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              iconData,
              size: 20,
              color: Constants.primaryColorDarker,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.primaryColorDarker,
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                height: 0.09,
                letterSpacing: 0.02,
              ),
            ),
          ],
        ));
  }
}