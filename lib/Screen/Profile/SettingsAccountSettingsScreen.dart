import 'package:digital_nfc_card/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';

class SettingsAccountSettingsScreen extends StatefulWidget {
  const SettingsAccountSettingsScreen({super.key});

  @override
  State<SettingsAccountSettingsScreen> createState() =>
      _SettingsAccountSettingsScreenState();
}

class _SettingsAccountSettingsScreenState extends State<SettingsAccountSettingsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmNewPassword = true;

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
                  'Account Settings',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 26,)
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
                child: Form(
                  key: _formKey,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Current Password',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Constants.primaryColorDarker,
                                          fontSize: Constants.responsiveFlex(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width) >
                                                  0
                                              ? 20
                                              : 18,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          height: 0.09,
                                          letterSpacing: 0.02,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        controller: currentPasswordController,
                                        keyboardType: TextInputType.name,
                                        obscureText: _obscureOldPassword,
                                        decoration: InputDecoration(
                                          hintText: "Enter your current password",
                                          hintStyle: TextStyle(
                                            color: Constants.primaryColorDarker,
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 18.0, vertical: 10),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureOldPassword =
                                                    !_obscureOldPassword;
                                              });
                                            },
                                            icon: !_obscureOldPassword
                                                ? const Icon(
                                                    Icons.visibility_outlined)
                                                : const Icon(Icons
                                                    .visibility_off_outlined)),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.8,
                                              strokeAlign: BorderSide.strokeAlignInside,
                                              color: Constants.primaryColorDarker,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.8,
                                              strokeAlign: BorderSide.strokeAlignCenter,
                                              color: Constants.primaryColorDarker,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter your current password.";
                                          }
                                          // else if (!_boxAccounts.containsKey(value)) {
                                          //   return "Username is not registered.";
                                          // }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: Constants.responsiveFlex(
                                                MediaQuery.of(context).size.width) >
                                            0
                                        ? 24
                                        : 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'New Password',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Constants.primaryColorDarker,
                                          fontSize: Constants.responsiveFlex(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width) >
                                                  0
                                              ? 20
                                              : 18,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          height: 0.09,
                                          letterSpacing: 0.02,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        controller: newPasswordController,
                                        obscureText: _obscureNewPassword,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText: "Enter your new password",
                                          hintStyle: TextStyle(
                                            color: Constants.primaryColorDarker,
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 18.0, vertical: 10),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureNewPassword =
                                                    !_obscureNewPassword;
                                              });
                                            },
                                            icon: !_obscureNewPassword
                                                ? const Icon(
                                                    Icons.visibility_outlined)
                                                : const Icon(Icons
                                                    .visibility_off_outlined)),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.8,
                                              strokeAlign: BorderSide.strokeAlignInside,
                                              color: Constants.primaryColorDarker,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.8,
                                              strokeAlign: BorderSide.strokeAlignCenter,
                                              color: Constants.primaryColorDarker,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please Enter your new password.";
                                          }
                                          // else if (!_boxAccounts.containsKey(value)) {
                                          //   return "Username is not registered.";
                                          // }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: Constants.responsiveFlex(
                                                MediaQuery.of(context).size.width) >
                                            0
                                        ? 24
                                        : 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Confirm New Password',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Constants.primaryColorDarker,
                                          fontSize: Constants.responsiveFlex(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width) >
                                                  0
                                              ? 20
                                              : 18,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          height: 0.09,
                                          letterSpacing: 0.02,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        controller: confirmNewPasswordController,
                                        keyboardType: TextInputType.name,
                                        obscureText: _obscureConfirmNewPassword,
                                        decoration: InputDecoration(
                                          hintText: "Confirm your new password",
                                          hintStyle: TextStyle(
                                            color: Constants.primaryColorDarker,
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 18.0, vertical: 10),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureConfirmNewPassword =
                                                    !_obscureConfirmNewPassword;
                                              });
                                            },
                                            icon: !_obscureConfirmNewPassword
                                                ? const Icon(
                                                    Icons.visibility_outlined)
                                                : const Icon(Icons
                                                    .visibility_off_outlined)),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.8,
                                              strokeAlign: BorderSide.strokeAlignInside,
                                              color: Constants.primaryColorDarker,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.8,
                                              strokeAlign: BorderSide.strokeAlignCenter,
                                              color: Constants.primaryColorDarker,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please Confirm your new password.";
                                          }
                                          if (value != newPasswordController.text) {
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
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(320, 45)),
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
                              String response =
                                  await AuthService.changePasswordWithPassword(
                                      currentPasswordController.text,
                                      confirmNewPasswordController.text,
                                      context);
                              
                              if (context.mounted) {
                                if (response == "Success") {
                                  snackbarKey.currentState?.showSnackBar(
                                  Constants.SnackBarWidget(
                                          SnackBarType.success,
                                          "Password changed successfully!"));
                                } else {
                                  snackbarKey.currentState?.showSnackBar(
                                  Constants.SnackBarWidget(
                                          SnackBarType.error,
                                          response.contains("Wrong")
                                              ? "Wrong password."
                                              : "An error occured. Please try again."));
                                }
                              }
                            }
                          },
                          child: const Text(
                            'Save Changes',
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
