import 'package:digital_nfc_card/Screen/Login/LoginScreen.dart';
import 'package:digital_nfc_card/Screen/Register/RegisterScreen.dart';
import 'package:digital_nfc_card/Screen/Widgets/TextFormFieldWidget.dart';
import 'package:digital_nfc_card/Services/AuthService.dart';
import 'package:digital_nfc_card/Services/TokenStorageService.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class ResetPasswordScreen extends StatefulWidget {
  String email;
  ResetPasswordScreen(this.email, {super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controllerVerification = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isResendButtonDisabled = false;

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
                              'Reset Password',
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
                          TextFormFieldWidget(
                            option: "Verification Code",
                            hintText: "Your verification code",
                            textEditingController: _controllerVerification,
                            textInputType: TextInputType.name,
                            validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please tour verification code.";
                                    }
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
                                  obscureText: _obscurePassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "Your new password",
                                    hintStyle: const TextStyle(
                                      color: Color(0x7F040658),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
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
                                            : const Icon(
                                                Icons.visibility_off_outlined)),
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
                                      return "Please enter password.";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _controllerConfirmPassword,
                                  obscureText: _obscureConfirmPassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "Confirm your new password",
                                    hintStyle: const TextStyle(
                                      color: Color(0x7F040658),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
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
                                            : const Icon(
                                                Icons.visibility_off_outlined)),
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
                                      return "Please confirm password.";
                                    } else if (value !=
                                        _controllerPassword.text) {
                                      return "Password does not match.";
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
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              bool response =
                                  await AuthService.changePasswordWithResetCode(
                                      widget.email,
                                      _controllerVerification.text,
                                      _controllerConfirmPassword.text,
                                      context);

                              if (response) {
                                snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
                                          SnackBarType.success,
                                          'Password changed successfully!'));
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const LoginScreen();
                                      },
                                    ),
                                  );
                                }
                              } else {
                                snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
                                          SnackBarType.error,
                                          'Password change failed!'));
                              }
                            }
                          },
                          child: const Text(
                            'Reset and Save Your Password',
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
                        const SizedBox(height: 20),
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
                          onPressed: isResendButtonDisabled
                              ? () {}
                              : () async {
                                  setState(() {
                                    isResendButtonDisabled = true;
                                  });
                                  var email =
                                      await TokenStorageService.getEmail();
                                  if (email != null) {
                                    await AuthService.sendResetPasswordCode(
                                            email, context)
                                        .then((value) => setState(() {
                                              isResendButtonDisabled = false;
                                            }));
                                  }
                                },
                          child: const Text(
                            'Resend Verification Code',
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
                          height: 100,
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
                    color: Constants.backgroundColor)),
          ],
        ),
      ),
    );
  }
}
