// ignore_for_file: use_build_context_synchronously


import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Login/LoginScreen.dart';
import 'package:digital_nfc_card/Screen/Register/ProfileInformation.dart';
import 'package:digital_nfc_card/Screen/Widgets/TextFormFieldWidget.dart';
import 'package:digital_nfc_card/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    userDataProvider.clearNewUserData();
    userDataProvider.clearUserDataList();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(   
      backgroundColor: Constants.backgroundColor,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                flex: Constants.responsiveFlex(
                    MediaQuery.of(context).size.width),
                child: Container(
                    alignment: Alignment.center,
                    color: Constants.backgroundColor)),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 90),
                          Column(
                              children: [
                                Text(
                                  Constants.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.primaryColorDarker,
                                    fontSize: Constants.responsiveFlex(
                                                MediaQuery.of(context).size.width) >
                                            0
                                        ? 48
                                        : 24,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  Constants.poweredBy,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.primaryColorDarker,
                                    fontSize: Constants.responsiveFlex(
                                                MediaQuery.of(context).size.width) >
                                            0
                                        ? 24
                                        : 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 68),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Register',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Constants.primaryColorDarker,
                                fontSize: Constants.responsiveFlex(
                                            MediaQuery.of(context)
                                                .size
                                                .width) >
                                        0
                                    ? 30
                                    : 26,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          TextFormFieldWidget(
                            option: "Email",
                            hintText: "Enter your email address",
                            textEditingController: _controllerEmail,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address.';
                              }
                              // Use a regular expression to check for a valid email format
                              final RegExp emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    
                              if (!emailRegex.hasMatch(value)) {
                                return 'Please enter a valid email address.';
                              }
                              // The email is considered valid
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          // Password SizeBox
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Constants.primaryColorDarker,
                                    fontSize: Constants.responsiveFlex(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) >
                                            0
                                        ? 26
                                        : 20,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    height: 0.09,
                                    letterSpacing: 0.02,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _controllerPassword,
                                  focusNode: _focusNodePassword,
                                  obscureText: _obscurePassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "Enter a password",
                                    hintStyle: TextStyle(
                                      color: Constants.primaryColorDarker,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 10),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                        icon: !_obscurePassword
                                            ? const Icon(
                                                Icons.visibility_outlined)
                                            : const Icon(Icons
                                                .visibility_off_outlined)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.8,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Constants.primaryColorDarker,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.8,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Constants.primaryColorDarker,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter a password.";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _controllerConfirmPassword,
                                  focusNode: _focusNodeConfirmPassword,
                                  obscureText: _obscureConfirmPassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "Confirm your password",
                                    hintStyle: TextStyle(
                                      color: Constants.primaryColorDarker,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 10),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword =
                                                !_obscureConfirmPassword;
                                          });
                                        },
                                        icon: !_obscureConfirmPassword
                                            ? const Icon(
                                                Icons.visibility_outlined)
                                            : const Icon(Icons
                                                .visibility_off_outlined)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.8,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Constants.primaryColorDarker,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.8,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Constants.primaryColorDarker,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your password again.";
                                    } else if (value !=
                                        _controllerPassword.text) {
                                      return "Passwords do not match.";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left : 30.0, right: 30.0, top: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: Constants.responsiveFlex(
                                        MediaQuery.of(context).size.width) >
                                    0
                                ? MaterialStateProperty.all(
                                    const Size(300, 44))
                                : MaterialStateProperty.all(
                                    const Size(double.infinity, 44)),
                            maximumSize: Constants.responsiveFlex(
                                        MediaQuery.of(context).size.width) >
                                    0
                                ? MaterialStateProperty.all(
                                    const Size(400, 44))
                                : null,
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
                          onPressed: isButtonDisabled
                              ? () {}
                              : () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    setState(() {
                                      isButtonDisabled = true;
                                    }); // Pass the context
                                    try {
                                      
                                      var response =
                                          await AuthService.register(
                                              context,
                                              _controllerEmail.text,
                                              _controllerPassword.text);
                                      print("Response : $response");
                                      if (response != "Success") {
                                        snackbarKey.currentState?.showSnackBar(
                                        Constants.SnackBarWidget(
                                        SnackBarType.error,
                                        '$response'));
                                      } else {
                                        snackbarKey.currentState?.showSnackBar(
                                        Constants.SnackBarWidget(
                                            SnackBarType.success,
                                            'Registration successful.'));
                                        userDataProvider.isCreatingMoreCards =
                                            true;
                                        userDataProvider.isCreatingFirstCard =
                                            true;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const ProfileInformationScreen();
                                            },
                                          ),
                                        );
                                      }
                                    } catch (error) {
                                      // handle login error
                                    } finally {
                                      setState(() {
                                        isButtonDisabled = false;
                                      });
                                    }
                                  }
                                },
                          child: const Text(
                            'Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFBFBFB),
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              height: 0.09,
                              letterSpacing: 0.02,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _formKey.currentState?.reset();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const LoginScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Already have an account?',
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: Constants.responsiveFlex(
                    MediaQuery.of(context).size.width),
                child: Container(
                    alignment: Alignment.center,
                    color: Constants.backgroundColor)),
          ],
        ),
      ),
    );
  }
}
