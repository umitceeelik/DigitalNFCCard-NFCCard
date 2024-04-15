import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class SettingsPrivacySecurityScreen extends StatefulWidget {
  const SettingsPrivacySecurityScreen({super.key});

  @override
  State<SettingsPrivacySecurityScreen> createState() =>
      _SettingsPrivacySecurityScreenState();
}

class _SettingsPrivacySecurityScreenState extends State<SettingsPrivacySecurityScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  final bool _obscurePassword = true;

  List<PrivacySecurityBox> privacySecurityList = [
    PrivacySecurityBox("Public Profile", "Anyone who visits my profile can see all of my information.", (p0) => null),
    PrivacySecurityBox("Hide Contract Details", "If no NFC card scan, hide contact information on my profile.", (p0) => null),
    PrivacySecurityBox("Private Profile", "If no NFC card scan, hide my profile information.", (p0) => null),
  ];
  PrivacySecurityBox? currentOption;

  @override
  Widget build(BuildContext context) {
    double appBarHeightMultiplier = 0.07;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    EdgeInsets padding = MediaQuery.of(context).padding;
    
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * appBarHeightMultiplier), // Adjust the height as needed
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
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 26,
                    color: Constants.primaryColorDarker,
                  ),
                ),
                const Text(
                  'Privacy & Security',
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
            fontSize:
                Constants.responsiveFlex(screenWidth) > 0
                    ? 30
                    : 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
          // leading: Padding(
          //   padding: EdgeInsets.only(
          //       left: Constants.responsiveFlex(
          //                   MediaQuery.of(context).size.width) >
          //               0
          //           ? 30 + MediaQuery.of(context).size.width / 7
          //           : 30,
          //       top: 20),
          //   child: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: const Icon(
          //       Icons.arrow_back_ios,
          //       size: 26,
          //       color: Constants.primaryColorDarker,
          //     ),
          //   ),
          // ),
          elevation: 0.0,
          backgroundColor: Constants.backgroundColor,
          surfaceTintColor: Constants.backgroundColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                flex:
                    Constants.responsiveFlex(screenWidth),
                child: Container(
                    alignment: Alignment.center,
                    color: Constants.backgroundColor)),
            Expanded(
              flex: 5,
              child: SizedBox(
                width: screenWidth,
                height: screenHeight - screenHeight * appBarHeightMultiplier - padding.top - padding.bottom,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      top: Constants.responsiveFlex(
                                  MediaQuery.of(context).size.width) >
                              0
                          ? 110
                          : 60,
                      bottom: Constants.responsiveFlex(
                                  MediaQuery.of(context).size.width) >
                              0
                          ? 60
                          : 48),
                  child: Column(
                    children: [
                      ...privacySecurityList.map((card) {
                                    currentOption ??= privacySecurityList[0];
                                    return RadioListTile<PrivacySecurityBox>(
                                      title: card,
                                      value: card,
                                      activeColor: Constants.primaryColorDarker,
                                      contentPadding: EdgeInsets.zero,
                                      groupValue: currentOption,
                                      onChanged: (value) {
                                        setState(() {
                                          currentOption = value;
                                        });
                                      },
                                    );
                                  }),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex:
                    Constants.responsiveFlex(screenWidth),
                child: Container(
                    alignment: Alignment.center,
                    color: Constants.backgroundColor)),
          ],
        ),
      ),
    );
  }
}


class PrivacySecurityBox extends StatelessWidget {
  final String name;
  final String detail;
  final Function(PrivacySecurityBox) onPressed;

  const PrivacySecurityBox(this.name, this.detail, this.onPressed, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      child: Container(
        // color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                name,
                style: TextStyle(
                  color: Constants.primaryColorDarker,
                  fontSize: Constants.responsiveFlex(
                              MediaQuery.of(context).size.width) >
                          0
                      ? 20
                      : 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  letterSpacing: 0.02,
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: Text(
                detail,
                style: TextStyle(
                  color: Constants.primaryColorDarker,
                  fontSize: Constants.responsiveFlex(
                              MediaQuery.of(context).size.width) >
                          0
                      ? 18
                      : 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.07,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}