import 'package:digital_nfc_card/Screen/Login/ResetPasswordScreen.dart';
import 'package:digital_nfc_card/Screen/Register/RegisterScreen.dart';
import 'package:digital_nfc_card/Screen/Widgets/TextFormFieldWidget.dart';
import 'package:digital_nfc_card/Services/AuthService.dart';
import 'package:digital_nfc_card/Services/TokenStorageService.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                flex:
                    Constants.responsiveFlex(MediaQuery.of(context).size.width),
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
                              'Forgot your password?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Constants.primaryColorDarker,
                                fontSize: Constants.responsiveFlex(
                                            MediaQuery.of(context).size.width) >
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
                          // Email SizeBox
                          TextFormFieldWidget(
                            option: "Email",
                            hintText: "Enter Your email address",
                            textEditingController: _controllerUsername,
                            textInputType: TextInputType.name
                          ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         'Email',
                          //         textAlign: TextAlign.start,
                          //         style: TextStyle(
                          //           color: Constants.primaryColorDarker,
                          //           fontSize: Constants.responsiveFlex(
                          //                       MediaQuery.of(context)
                          //                           .size
                          //                           .width) >
                          //                   0
                          //               ? 26
                          //               : 20,
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.w600,
                          //           height: 0.09,
                          //           letterSpacing: 0.02,
                          //         ),
                          //       ),
                          //       const SizedBox(height: 20),
                          //       TextFormField(
                          //         controller: _controllerUsername,
                          //         keyboardType: TextInputType.name,
                          //         decoration: InputDecoration(
                          //           hintText: "Enter Your email address",
                          //           hintStyle: const TextStyle(
                          //             color: Constants.primaryColorDarker,
                          //             fontSize: 14,
                          //             fontFamily: 'Montserrat',
                          //             fontWeight: FontWeight.w400,
                          //             height: 0,
                          //           ),
                          //           contentPadding: const EdgeInsets.symmetric(
                          //               horizontal: 18.0, vertical: 15),
                          //           border: OutlineInputBorder(
                          //             borderSide: const BorderSide(
                          //               width: 1.8,
                          //               strokeAlign:
                          //                   BorderSide.strokeAlignInside,
                          //               color: Constants.primaryColorDarker,
                          //             ),
                          //             borderRadius: BorderRadius.circular(5),
                          //           ),
                          //           enabledBorder: OutlineInputBorder(
                          //             borderSide: const BorderSide(
                          //               width: 1.8,
                          //               strokeAlign:
                          //                   BorderSide.strokeAlignCenter,
                          //               color: Constants.primaryColorDarker,
                          //             ),
                          //             borderRadius: BorderRadius.circular(5),
                          //           ),
                          //         ),
                          //         onEditingComplete: () =>
                          //             _focusNodePassword.requestFocus(),
                          //         validator: (String? value) {
                          //           if (value == null || value.isEmpty) {
                          //             return "Please enter email address.";
                          //           }
                          //           // else if (!_boxAccounts.containsKey(value)) {
                          //           //   return "Username is not registered.";
                          //           // }

                          //           return null;
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: Constants.responsiveFlex(
                                        MediaQuery.of(context).size.width) >
                                    0
                                ? MaterialStateProperty.all(const Size(300, 44))
                                : MaterialStateProperty.all(
                                    const Size(double.infinity, 44)),
                            maximumSize: Constants.responsiveFlex(
                                        MediaQuery.of(context).size.width) >
                                    0
                                ? MaterialStateProperty.all(const Size(400, 44))
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
                          onPressed: () async{
                            if (_formKey.currentState?.validate() ?? false) {
                              AuthService.sendResetPasswordCode(
                                  _controllerUsername.text, context);
                              await TokenStorageService.saveEmail(
                                  _controllerUsername.text);
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ResetPasswordScreen(
                                          _controllerUsername.text);
                                    },
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text(
                            'Reset Password',
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
                                // const SizedBox(height: 150),
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
                flex:
                    Constants.responsiveFlex(MediaQuery.of(context).size.width),
                child: Container(
                    alignment: Alignment.center,
                    color: const Color.fromARGB(255, 224, 16, 16))),
          ],
        ),
      ),
    );
  }
}
