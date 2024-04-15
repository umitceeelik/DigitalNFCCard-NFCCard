import 'dart:io';

import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Profile/EditProfilePhotoScreen.dart';
import 'package:digital_nfc_card/Screen/Register/NFCCardIdentity.dart';
import 'package:digital_nfc_card/Screen/Register/SocialMedia.dart';
import 'package:digital_nfc_card/Screen/Widgets/TextFormFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerAboutYou = TextEditingController();

  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    userDataProvider.clearNewUserData();
  }

  void AddNewImage(String img) {
      setState(() {
        _image = File(img);
      });
  }

  Future<void> _navigateToPhotoScreen(BuildContext context, String? imagePath) async {
    final result = await Navigator.push(
      context,
      imagePath == null ? MaterialPageRoute(builder: (context) => const EditProfilePhotoScreen())
      : MaterialPageRoute(builder: (context) => EditProfilePhotoScreen(imagePath: imagePath)),
    );
    if (result == null) return;
    print(result);        
    if (result['imagePath'] != "") {
      AddNewImage(result['imagePath']);
    }
  }

  final bool _obscurePassword = true;

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
                Provider.of<UserDataProvider>(context, listen: false).isCreatingMoreCards
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 26,
                      color: Constants.primaryColorDarker,
                    ),
                  )
                : const SizedBox(width: 26),
                const Text(
                  'Create A Profile',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 26,
                ),
              ],
            ),
          ),
          titleTextStyle: TextStyle(
            color: Constants.primaryColorDarker,
            fontSize:
                Constants.responsiveFlex(MediaQuery.of(context).size.width) > 0
                    ? 30
                    : 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
          automaticallyImplyLeading: false,
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
                child: Column(
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
                                  Icons.person,
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
                                          'Step 1/6',
                                          style: TextStyle(
                                            color: Constants.primaryColorLighter,
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
                                          'Profile Information',
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
                              value: 1 / 6,
                              color: Constants.primaryColor,
                              backgroundColor: const Color(0xFFB4C4D0),
                              semanticsLabel: 'Linear progress indicator',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Padding(
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
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    _image == null ? _navigateToPhotoScreen(context, null)
                                    : _navigateToPhotoScreen(context, _image!.path);
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 88,
                                      height: 88,
                                      decoration: const ShapeDecoration(
                                        color: Color(0x7FB5B5B5),
                                        shape: OvalBorder(
                                          side: BorderSide(
                                            width: 3,
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside,
                                            color: Color(0xFFFBFBFB),
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: _image == null ? Icon(
                                          Icons.add_photo_alternate,
                                          size: 24,
                                          color: Constants.primaryColorDarker,
                                        )
                                        : CircleAvatar(
                                          backgroundImage: FileImage(_image!),
                                          radius: 88,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Constants.responsiveFlex(
                                          MediaQuery.of(context).size.width) >
                                      0
                                  ? 24
                                  : 20
                                ),
                                TextFormFieldWidget(
                                  option: "First Name(*)",
                                  hintText: "Enter your first name",
                                  textEditingController: _controllerFirstName,
                                  textInputType: TextInputType.name,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your name.";
                                    } else if (value.length < 3) {
                                      return "Please enter at least 3 characters.";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormFieldWidget(
                                  option: "Last Name(*)",
                                  hintText: "Enter your last name",
                                  textEditingController: _controllerLastName,
                                  textInputType: TextInputType.name,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your last name.";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormFieldWidget(
                                  option: "Title",
                                  hintText: "Enter your title",
                                  textEditingController: _controllerTitle,
                                  textInputType: TextInputType.name
                                ),                             
                                SizedBox(
                                  height: Constants.responsiveFlex(
                                          MediaQuery.of(context).size.width) >
                                      0
                                  ? 24
                                  : 20
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'About You',
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
                                        controller: _controllerAboutYou,
                                        keyboardType: TextInputType.text,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                          hintText:
                                              "What would you like people to know about yourself?",
                                          hintStyle: TextStyle(
                                            color: Constants.primaryColorDarker,
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 18.0,
                                                  vertical: 10),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.8,
                                              strokeAlign:
                                                  BorderSide.strokeAlignInside,
                                              color: Constants.primaryColorDarker,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.8,
                                              strokeAlign:
                                                  BorderSide.strokeAlignCenter,
                                              color: Constants.primaryColorDarker,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                      ),
                    ),
                    Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // _formKey.currentState?.reset();
                            Provider.of<UserDataProvider>(context,listen: false)
                              .setNames(_controllerFirstName.text, _controllerLastName.text, _controllerTitle.text, _controllerAboutYou.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const NFCCardIdentityScreen();
                                },
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Skip',
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
                                .setNames(_controllerFirstName.text, _controllerLastName.text, _controllerTitle.text, _controllerAboutYou.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SocialMediaScreen();
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
