// ignore_for_file: use_build_context_synchronously

import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Login/ForgotPasswordScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/ProfileScreen.dart';
import 'package:digital_nfc_card/Screen/Register/ProfileInformation.dart';
import 'package:digital_nfc_card/Screen/Register/RegisterScreen.dart';
import 'package:digital_nfc_card/Screen/Widgets/TextFormFieldWidget.dart';
import 'package:digital_nfc_card/Services/AuthService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscurePassword = true;

  bool isButtonDisabled = false;
  
  @override
  Widget build(BuildContext context) {
    var userDataProvider = Provider.of<UserDataProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 80),
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
                                'Login',
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
                            TextFormFieldWidget(
                              option: "Password",
                              hintText: "Enter your password",
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: !_obscurePassword
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined)),
                              textEditingController: _controllerPassword,
                              textInputType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password.';
                                }
                                // Add more validation logic if needed
                                return null; // Return null if the input is valid
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
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
                                      });
                                      try {
                                        var response = await AuthService.login(
                                            context,
                                            _controllerEmail.text,
                                            _controllerPassword.text);
                                        if (kDebugMode) {
                                          print("Response : $response");
                                        }
                                        if (response != "Success") {
                                          snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
                                          SnackBarType.error,
                                          '$response'));        
                                        } else {
                                          bool response = await AuthService
                                              .fetchDataFromAws(
                                            context,
                                            null,
                                          );
                                          if (response) {
                                            userDataProvider
                                                .isCreatingMoreCards = false;
                                            userDataProvider
                                                .isCreatingFirstCard = false;
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const ProfileScreen();
                                                },
                                              ),
                                            );
                                          } else {
                                            userDataProvider
                                                .isCreatingMoreCards = true;
                                            userDataProvider
                                                .isCreatingFirstCard = true;
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const ProfileInformationScreen();
                                                },
                                              ),
                                            );
                                          }
                                        }
                                      } catch (error) {
                                        snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
                                          SnackBarType.error,
                                          'Something went wrong. Please try again later.'));
                                      } finally {
                                        setState(() {
                                                isButtonDisabled = false;
                                        });
                                      }
                                    }
                                  },
                            child: const Text(
                              'Sign In',
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const ForgotPasswordScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot your password?',
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
                                  const SizedBox(height: 10),
                                  TextButton(
                                    onPressed: () {
                                      _formKey.currentState?.reset();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const RegisterScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Don’t have an account?',
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
                      color: const Color.fromARGB(255, 0, 0, 0))),
            ],
          ),
        ),
      ),
    );
  }
}
