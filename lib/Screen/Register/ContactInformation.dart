import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Register/NFCCardIdentity.dart';
import 'package:digital_nfc_card/Screen/Register/WorkInformation.dart';
import 'package:digital_nfc_card/Screen/Widgets/TextFormFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class ContactInformationScreen extends StatefulWidget {
  const ContactInformationScreen({super.key});

  @override
  State<ContactInformationScreen> createState() =>
      _ContactInformationScreenState();
}

class _ContactInformationScreenState extends State<ContactInformationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerWebsite = TextEditingController();

  final bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    double appBarHeightMultiplier = 0.07;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight *
            appBarHeightMultiplier), // Adjust the height as needed
        child: AppBar(
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Create An Account',
              textAlign: TextAlign.center,
            ),
          ),
          titleTextStyle: TextStyle(
            color: Constants.primaryColorDarker,
            fontSize: Constants.responsiveFlex(screenWidth) > 0 ? 30 : 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
          leading: Padding(
            padding: EdgeInsets.only(
                left: Constants.responsiveFlex(
                            MediaQuery.of(context).size.width) >
                        0
                    ? 30 + MediaQuery.of(context).size.width / 7
                    : 30,
                top: 20),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 26,
                color: Constants.primaryColorDarker,
              ),
            ),
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
                    screenHeight - screenHeight * appBarHeightMultiplier * 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: SizedBox(
                            width: screenWidth,
                            // color: Colors.amber,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.connect_without_contact_rounded,
                                      size: Constants.responsiveFlex(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width) >
                                              0
                                          ? 50
                                          : 36,
                                      color: Constants.primaryColorDarker,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'Step 3/6',
                                              style: TextStyle(
                                                color: const Color(0x7F040658),
                                                fontSize:
                                                    Constants.responsiveFlex(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width) >
                                                            0
                                                        ? 18
                                                        : 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'Contact Information',
                                              style: TextStyle(
                                                color: Constants.primaryColorDarker,
                                                fontSize:
                                                    Constants.responsiveFlex(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width) >
                                                            0
                                                        ? 20
                                                        : 18,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.02,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                LinearProgressIndicator(
                                  value: 3 / 6,
                                  color: Constants.primaryColor,
                                  backgroundColor: const Color(0xFFB4C4D0),
                                  semanticsLabel: 'Linear progress indicator',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                left: 32.0,
                                right: 32.0,
                                top: Constants.responsiveFlex(
                                            MediaQuery.of(context).size.width) >
                                        0
                                    ? 60
                                    : 16,
                                bottom: Constants.responsiveFlex(
                                            MediaQuery.of(context).size.width) >
                                        0
                                    ? 60
                                    : 48),
                            child: Column(
                              children: [
                                TextFormFieldWidget(
                                    option: "Phone Number",
                                    hintText: "Enter your phone number",
                                    textEditingController:
                                        _controllerPhoneNumber,
                                    textInputType: TextInputType.number),
                                SizedBox(
                                    height: Constants.responsiveFlex(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) >
                                            0
                                        ? 24
                                        : 20),
                                TextFormFieldWidget(
                                    option: "Email",
                                    hintText: "Enter your email address",
                                    textEditingController: _controllerEmail,
                                    textInputType: TextInputType.emailAddress),
                                SizedBox(
                                    height: Constants.responsiveFlex(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) >
                                            0
                                        ? 24
                                        : 20),
                                TextFormFieldWidget(
                                    option: "Website",
                                    hintText: "Enter your web address",
                                    textEditingController: _controllerWebsite,
                                    textInputType: TextInputType.url),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const NFCCardIdentityScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Skip",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.primaryColor,
                                fontSize: 18,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                height: 0.09,
                                letterSpacing: 0.02,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(const Size(71, 45)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Constants.primaryHoverColor;
                                } else {
                                  return Constants.primaryColor;
                                }
                              }),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                Provider.of<UserDataProvider>(context,
                                        listen: false)
                                    .setContactInformation(
                                        _controllerPhoneNumber.text,
                                        _controllerEmail.text,
                                        _controllerWebsite.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const WorkInformationScreen();
                                    },
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFBFBFB),
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                height: 0.09,
                                letterSpacing: 0.02,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
}
