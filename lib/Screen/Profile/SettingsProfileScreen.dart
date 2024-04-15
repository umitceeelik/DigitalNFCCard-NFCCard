import 'dart:io';

import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Profile/EditProfilePhotoScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/ProfileScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsSocialMediaScreen.dart';
import 'package:digital_nfc_card/Screen/Widgets/EducationWidget/EducationControllers.dart';
import 'package:digital_nfc_card/Screen/Widgets/EducationWidget/EducationWidget.dart';
import 'package:digital_nfc_card/Screen/Widgets/EducationWidget/EducationWidgetData.dart';
import 'package:digital_nfc_card/Screen/Widgets/TextFormFieldWidget.dart';
import 'package:digital_nfc_card/Screen/Widgets/WorkWidget/WorkControllers.dart';
import 'package:digital_nfc_card/Screen/Widgets/WorkWidget/WorkWidget.dart';
import 'package:digital_nfc_card/Screen/Widgets/WorkWidget/WorkWidgetData.dart';
import 'package:digital_nfc_card/Services/TokenStorageService.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class SettingsProfileScreen extends StatefulWidget {
  const SettingsProfileScreen({super.key});

  @override
  State<SettingsProfileScreen> createState() => _SettingsProfileScreenState();
}

class _SettingsProfileScreenState extends State<SettingsProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();

  // Profile Info Controller
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerAboutYou = TextEditingController();

  // Contact Info Controller
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerWebsite = TextEditingController();

  int currentIndex = 0;

  File? _image;

  void AddNewImage(String img) {
    setState(() {
      _image = File(img);
    });
  }

  Future<void> _navigateToPhotoScreen(
      BuildContext context, String? imagePath) async {
    print("aa");
    final result = await Navigator.push(
      context,
      imagePath == null
          ? MaterialPageRoute(
              builder: (context) => const EditProfilePhotoScreen())
          : MaterialPageRoute(
              builder: (context) =>
                  EditProfilePhotoScreen(imagePath: imagePath)),
    );
    print(result);
    if (result['imagePath'] != "") {
      AddNewImage(result['imagePath']);
      // Provider.of<UserDataProvider>(context, listen: false)
      //     .userData
      //     .profileImagePath = result['imagePath'];
    } else {
      setState(() {
        _image = null;
      });
    }
  }

  List<WorkWidgetData> workWidgetsData = [];
  List<WorkWidgetData> workWidgetsDataForSave = [];
  List<EducationWidgetData> educationWidgetsData = [];
  List<EducationWidgetData> educationWidgetsDataForSave = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTheExistsValues();
  }

  @override
  Widget build(BuildContext context) {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
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
                IconButton(
                  onPressed: () {
                    _showBackConfirmationDialog(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 26,
                    color: Constants.primaryColorDarker,
                  ),
                ),
                const Text(
                  'Profile',
                  textAlign: TextAlign.center,
                ),
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        print("saving");
                        await saveNewValues().then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ProfileScreen();
                                },
                              ),
                            ));
                      }
                    },
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        height: 0.09,
                        letterSpacing: 0.02,
                      ),
                    )),
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
                height: screenHeight -
                    screenHeight * appBarHeightMultiplier -
                    padding.top -
                    padding.bottom,
                child: Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                              top: Constants.responsiveFlex(
                                          MediaQuery.of(context).size.width) >
                                      0
                                  ? 60
                                  : 26,
                              // bottom: Constants.responsiveFlex(
                              //             MediaQuery.of(context).size.width) >
                              //         0
                              //     ? 60
                              //     : 48
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    left: 14,
                                    right: 14,
                                    bottom: 16,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: Constants.primaryBgColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisSize: Constants.responsiveFlex(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) >
                                            0
                                        ? MainAxisSize.max
                                        : MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 88,
                                        height: 88,
                                        decoration: ShapeDecoration(
                                          color: Constants.primaryBgColor,
                                          shape: const OvalBorder(
                                            side: BorderSide(
                                              width: 3,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                              color: Color(0xFFFBFBFB),
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: _image == null
                                              ? Icon(
                                                  Icons.add_photo_alternate,
                                                  size: 24,
                                                  color: Constants.primaryColorDarker,
                                                )
                                              : CircleAvatar(
                                                  backgroundImage:
                                                      FileImage(_image!),
                                                  radius: 88,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 22,
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            minimumSize:
                                                Constants.responsiveFlex(
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) >
                                                        0
                                                    ? MaterialStateProperty.all(
                                                        const Size(160, 46))
                                                    : MaterialStateProperty.all(
                                                        const Size(160, 46)),
                                            maximumSize:
                                                Constants.responsiveFlex(
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) >
                                                        0
                                                    ? MaterialStateProperty.all(
                                                        const Size(160, 46))
                                                    : null,
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                return Constants
                                                    .primaryHoverColor;
                                              } else {
                                                return Constants.primaryBgColor;
                                              }
                                            }),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  strokeAlign: BorderSide
                                                      .strokeAlignOutside,
                                                  color: Constants.primaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            _image == null
                                                ? _navigateToPhotoScreen(
                                                    context, null)
                                                : _navigateToPhotoScreen(
                                                    context, _image!.path);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                size: 20,
                                                color: Constants.primaryColor,
                                              ),
                                              Text(
                                                'Edit Picture',
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
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: Constants.responsiveFlex(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) >
                                            0
                                        ? 30
                                        : 10),
                                if (currentIndex == 0) ...[
                                  const SizedBox(height: 10),
                                  // Profile Infos
                                  Container(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      left: 14,
                                      right: 14,
                                      bottom: 18,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: Constants.primaryBgColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: Column(
                                      children: [
                                        TextFormFieldWidget(
                                          option: "First Name(*)",
                                          hintText: "Enter your first name",
                                          textEditingController:
                                              _controllerFirstName,
                                          textInputType: TextInputType.name,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                          textEditingController:
                                              _controllerLastName,
                                          textInputType: TextInputType.name,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your last name.";
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormFieldWidget(
                                            option: "Title",
                                            hintText: "Enter your title",
                                            textEditingController:
                                                _controllerTitle,
                                            textInputType: TextInputType.name),
                                        SizedBox(
                                            height: Constants.responsiveFlex(
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width) >
                                                    0
                                                ? 24
                                                : 20),
                                        // About You text field
                                        SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'About You',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color:
                                                      Constants.primaryColorDarker,
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
                                                  height: 0.09,
                                                  letterSpacing: 0.02,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              TextFormField(
                                                // initialValue: "Hello, I'm Jessica. I work as a web developer. I love meeting new people!",
                                                controller: _controllerAboutYou,
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLines: 2,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "What would you like people to know about yourself?",
                                                  hintStyle: TextStyle(
                                                    color: Constants.primaryColorDarker,
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 18.0,
                                                          vertical: 10),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(
                                                      width: 1.8,
                                                      strokeAlign: BorderSide
                                                          .strokeAlignInside,
                                                      color: Constants.primaryColorDarker,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(
                                                      width: 1.8,
                                                      strokeAlign: BorderSide
                                                          .strokeAlignCenter,
                                                      color: Constants.primaryColorDarker,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Social Media
                                  Container(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 14,
                                      right: 14,
                                      bottom: 10,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: Constants.primaryBgColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Social Media',
                                            style: TextStyle(
                                              color: Constants.primaryColorDarker,
                                              fontSize: 20,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return const SettingsSocialMediaScreen();
                                                  },
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 20,
                                              color: Constants.primaryColorDarker,
                                            ),
                                          )
                                        ]),
                                  ),
                                  const SizedBox(height: 10),
                                  // Contact Infos
                                  Container(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 14,
                                      right: 14,
                                      bottom: 16,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: Constants.primaryBgColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Contact',
                                            style: TextStyle(
                                              color: Constants.primaryColorDarker,
                                              fontSize: 20,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          SizedBox(
                                              height: Constants.responsiveFlex(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width) >
                                                      0
                                                  ? 10
                                                  : 8),
                                          TextFormFieldWidget(
                                              option: "Phone number",
                                              hintText: "+90 555 222 11 11",
                                              textEditingController:
                                                  _controllerPhoneNumber,
                                              textInputType:
                                                  TextInputType.phone),
                                          TextFormFieldWidget(
                                              option: "Email Address",
                                              hintText:
                                                  "Enter your email address",
                                              textEditingController:
                                                  _controllerEmail,
                                              textInputType:
                                                  TextInputType.emailAddress),
                                          TextFormFieldWidget(
                                              option: "Website",
                                              hintText: "Enter your website",
                                              textEditingController:
                                                  _controllerWebsite,
                                              textInputType: TextInputType.url),
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Work Infos
                                  Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 14,
                                        right: 14,
                                        bottom: 16,
                                      ),
                                      decoration: ShapeDecoration(
                                        color: Constants.primaryBgColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (workWidgetsData.isNotEmpty) ...[
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Work',
                                              style: TextStyle(
                                                color: Constants.primaryColorDarker,
                                                fontSize: 20,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                            SizedBox(
                                                height: Constants.responsiveFlex(
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width) >
                                                        0
                                                    ? 10
                                                    : 8),
                                          ],
                                          Column(
                                            children: workWidgetsData
                                                .map((data) => Column(
                                                      children: [
                                                        data.workWidget,
                                                        const SizedBox(
                                                          height: 18,
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                workWidgetsData
                                                                    .remove(
                                                                        data);
                                                              });
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.delete,
                                                                  size: 20,
                                                                  color: Constants.primaryColorDarker,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  'Delete',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Constants.primaryColorDarker,
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    height:
                                                                        0.09,
                                                                    letterSpacing:
                                                                        0.02,
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        const SizedBox(
                                                            height: 20),
                                                        const Divider(
                                                            height: 1,
                                                            thickness: 2.5,
                                                            color: Color(
                                                                0xFFB4C4D0)),
                                                        const SizedBox(
                                                            height: 10),
                                                      ],
                                                    ))
                                                .toList(),
                                          ),
                                          // const SizedBox(height: 40),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                minimumSize: Constants
                                                            .responsiveFlex(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width) >
                                                        0
                                                    ? MaterialStateProperty.all(
                                                        const Size(300, 44))
                                                    : MaterialStateProperty.all(
                                                        const Size(
                                                            double.infinity,
                                                            44)),
                                                maximumSize: Constants
                                                            .responsiveFlex(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width) >
                                                        0
                                                    ? MaterialStateProperty.all(
                                                        const Size(400, 44))
                                                    : null,
                                                backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                return Constants
                                                    .primaryHoverColor;
                                              } else {
                                                return Constants.primaryBgColor;
                                              }
                                            }),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  strokeAlign: BorderSide
                                                      .strokeAlignOutside,
                                                  color: Constants.primaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                              ),
                                              onPressed: () {
                                                addWorkWidget(
                                                    null, null, null, null);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    size: 20,
                                                    color: Constants.primaryColor,
                                                  ),
                                                  Text(
                                                    ' Add New Work',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Constants.primaryColor,
                                                      fontSize: 18,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0.09,
                                                      letterSpacing: 0.02,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Work Infos
                                  Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 14,
                                        right: 14,
                                        bottom: 16,
                                      ),
                                      decoration: ShapeDecoration(
                                        color: Constants.primaryBgColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (educationWidgetsData.isNotEmpty) ...[
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Education',
                                              style: TextStyle(
                                                color: Constants.primaryColorDarker,
                                                fontSize: 20,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                            SizedBox(
                                                height: Constants.responsiveFlex(
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width) >
                                                        0
                                                    ? 10
                                                    : 8),
                                          ],
                                          Column(
                                            children: educationWidgetsData
                                                .map((data) => Column(
                                                      children: [
                                                        data.educationWidget,
                                                        const SizedBox(
                                                          height: 18,
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                educationWidgetsData
                                                                    .remove(
                                                                        data);
                                                              });
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.delete,
                                                                  size: 20,
                                                                  color: Constants.primaryColorDarker,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  'Delete',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Constants.primaryColorDarker,
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    height:
                                                                        0.09,
                                                                    letterSpacing:
                                                                        0.02,
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        const SizedBox(
                                                            height: 20),
                                                        const Divider(
                                                            height: 1,
                                                            thickness: 2.5,
                                                            color: Color(
                                                                0xFFB4C4D0)),
                                                        const SizedBox(
                                                            height: 10),
                                                      ],
                                                    ))
                                                .toList(),
                                          ),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                minimumSize: Constants
                                                            .responsiveFlex(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width) >
                                                        0
                                                    ? MaterialStateProperty.all(
                                                        const Size(300, 44))
                                                    : MaterialStateProperty.all(
                                                        const Size(
                                                            double.infinity,
                                                            44)),
                                                maximumSize: Constants
                                                            .responsiveFlex(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width) >
                                                        0
                                                    ? MaterialStateProperty.all(
                                                        const Size(400, 44))
                                                    : null,
                                                backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                return Constants
                                                    .primaryHoverColor;
                                              } else {
                                                return Constants.primaryBgColor;
                                              }
                                            }),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  strokeAlign: BorderSide
                                                      .strokeAlignOutside,
                                                  color: Constants.primaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                              ),
                                              onPressed: () {
                                                addEducationWidget(null, null,
                                                    null, null, null);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    size: 20,
                                                    color: Constants.primaryColor,
                                                  ),
                                                  Text(
                                                    ' Add New Education',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Constants.primaryColor,
                                                      fontSize: 18,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0.09,
                                                      letterSpacing: 0.02,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      )),
                                ],
                                // const SizedBox(height: 18),
                              ],
                            ),
                          ),
                        ),
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

  void _showBackConfirmationDialog(BuildContext context) {
    showDialog(
      anchorPoint: const Offset(-1, 0),
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.bottomCenter,
          shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text on the left
              const Expanded(
                child: Text(
                  "Do you want to save the changes?",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xFF191919),
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        if (dialogContext.mounted) {
                          Navigator.of(dialogContext).pop();
                        }
                        if (_formKey.currentState?.validate() ?? false) {
                          await saveNewValues().then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ProfileScreen();
                                  },
                                ),
                              ));
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.02,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ProfileScreen();
                            },
                          ),
                        );
                      },
                      style: ButtonStyle(
                        // minimumSize:
                        //     MaterialStateProperty.all(const Size(45, 40)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Constants.primaryHoverColor;
                            } else {
                              return Constants.primaryColor;
                            }
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFFFBFBFB),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.02,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void setTheExistsValues() async {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    setState(() {
      workWidgetsData.clear();
      educationWidgetsData.clear();
    });

    // userDataProvider.clearEducationInformation();
    // userDataProvider.clearWorkInformation();

    if (userDataProvider.userData.image != null) {
      // List<int> imageBytes = await AuthService.fetchImageFromAws(
      //     userDataProvider.userData.cardInformation.idNumber);
      // print("girdi2");
      // // Get the temporary directory using path_provider
      // Directory tempDir = await getTemporaryDirectory();
      // // Create a File in the temporary directory
      // _image = File('${tempDir.path}/image.png');
      // // Write the bytes to the file
      // await _image!.writeAsBytes(imageBytes);
      // // setState(() {});
      _image = userDataProvider.userData.image;
    }

    _controllerFirstName.text = userDataProvider.userData.firstName;
    _controllerLastName.text = userDataProvider.userData.lastName;
    _controllerTitle.text = userDataProvider.userData.title;
    _controllerAboutYou.text = userDataProvider.userData.aboutYou;
    _controllerPhoneNumber.text = userDataProvider.userData.phoneNumber;
    _controllerEmail.text = userDataProvider.userData.contactEmail;
    _controllerWebsite.text = userDataProvider.userData.website;

    if (userDataProvider.userData.workInformationList.isNotEmpty) {
      for (int i = 0;
          i < userDataProvider.userData.workInformationList.length;
          i++) {
        addWorkWidget(
            userDataProvider.userData.workInformationList[i].companyName == ""
                ? null
                : userDataProvider.userData.workInformationList[i].companyName,
            userDataProvider.userData.workInformationList[i].jobTitle == ""
                ? null
                : userDataProvider.userData.workInformationList[i].jobTitle,
            userDataProvider.userData.workInformationList[i].taxId == ""
                ? null
                : userDataProvider.userData.workInformationList[i].taxId,
            userDataProvider.userData.workInformationList[i].iban == ""
                ? null
                : userDataProvider.userData.workInformationList[i].iban);
      }
    }
    if (userDataProvider.userData.educationInformationList.isNotEmpty) {
      for (int i = 0;
          i < userDataProvider.userData.educationInformationList.length;
          i++) {
        addEducationWidget(
            userDataProvider.userData.educationInformationList[i].schoolName ==
                    ""
                ? null
                : userDataProvider
                    .userData.educationInformationList[i].schoolName,
            userDataProvider.userData.educationInformationList[i].degree == ""
                ? null
                : userDataProvider.userData.educationInformationList[i].degree,
            userDataProvider
                        .userData.educationInformationList[i].fieldOfStudy ==
                    ""
                ? null
                : userDataProvider
                    .userData.educationInformationList[i].fieldOfStudy,
            userDataProvider
                        .userData.educationInformationList[i].startingDate ==
                    ""
                ? null
                : userDataProvider
                    .userData.educationInformationList[i].startingDate,
            userDataProvider.userData.educationInformationList[i].endingDate ==
                    ""
                ? null
                : userDataProvider
                    .userData.educationInformationList[i].endingDate);
      }
    }
  }

  Future<dynamic> saveNewValues() async {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    userDataProvider.clearEducationInformation();
    userDataProvider.clearWorkInformation();

    userDataProvider.userData.firstName = _controllerFirstName.text;
    userDataProvider.userData.lastName = _controllerLastName.text;
    userDataProvider.userData.title = _controllerTitle.text;
    userDataProvider.userData.aboutYou = _controllerAboutYou.text;
    userDataProvider.userData.phoneNumber = _controllerPhoneNumber.text;
    userDataProvider.userData.contactEmail = _controllerEmail.text;
    userDataProvider.userData.website = _controllerWebsite.text;

    for (int i = 0; i < workWidgetsData.length; i++) {
      userDataProvider.addWorkInformation(
          workWidgetsData[i].controllers.companyName.text,
          workWidgetsData[i].controllers.jobTitle.text,
          workWidgetsData[i].controllers.taxID.text,
          workWidgetsData[i].controllers.iban.text);
    }
    for (int i = 0; i < educationWidgetsData.length; i++) {
      userDataProvider.addEducationInformation(
        educationWidgetsData[i].controllers.school.text,
        educationWidgetsData[i].controllers.degree.text,
        educationWidgetsData[i].controllers.fieldOfStudy.text,
        educationWidgetsData[i].controllers.startDate.text,
        educationWidgetsData[i].controllers.endDate.text,
      );
    }

    userDataProvider.userData.profileImagePath = _image == null ? "" : _image!.path;
    userDataProvider.userData.image = _image;

    String? id = await TokenStorageService.getId();
    await userDataProvider.saveUserData(id, context);
  }

  void _showQRDialog(BuildContext context, IconData iconData) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 32, right: 32, top: 52, bottom: 60),
            child: Icon(
              iconData,
              size: 210,
              color: Constants.primaryColorDarker,
            ),
          ),
        );
      },
    );
  }

  void addWorkWidget(
      String? companyName, String? jobTitle, String? taxID, String? iban) {
    TextEditingController controllerCompanyName = TextEditingController();
    TextEditingController controllerJobTitle = TextEditingController();
    TextEditingController controllerTaxId = TextEditingController();
    TextEditingController controllerIban = TextEditingController();

    if (companyName != null) {
      controllerCompanyName.text = companyName;
    }
    if (jobTitle != null) {
      controllerJobTitle.text = jobTitle;
    }
    if (taxID != null) {
      controllerTaxId.text = taxID;
    }
    if (iban != null) {
      controllerIban.text = iban;
    }

    WorkWidgetData data = WorkWidgetData(
      workWidget: WorkWidget(
          companyNameController: controllerCompanyName,
          jobTitleController: controllerJobTitle,
          taxIDController: controllerTaxId,
          ibanController: controllerIban),
      controllers: WorkControllers(
          companyName: controllerCompanyName,
          jobTitle: controllerJobTitle,
          taxID: controllerTaxId,
          iban: controllerIban),
    );

    setState(() {
      workWidgetsData.add(data);
    });
  }

  void addEducationWidget(String? school, String? degree, String? fieldOfStudy,
      String? startDate, String? endDate) {
    TextEditingController controllerSchool = TextEditingController();
    TextEditingController controllerDegree = TextEditingController();
    TextEditingController controllerFieldOfStudy = TextEditingController();
    TextEditingController controllerSDate = TextEditingController();
    TextEditingController controllerEDate = TextEditingController();

    if (school != null) {
      controllerSchool.text = school;
    }
    if (degree != null) {
      controllerDegree.text = degree;
    }
    if (fieldOfStudy != null) {
      controllerFieldOfStudy.text = fieldOfStudy;
    }
    if (startDate != null) {
      controllerSDate.text = startDate;
    }
    if (endDate != null) {
      controllerEDate.text = endDate;
    }

    EducationWidgetData data = EducationWidgetData(
      educationWidget: EducationWidget(
        schoolController: controllerSchool,
        degreeController: controllerDegree,
        fieldOfStudyController: controllerFieldOfStudy,
        startDateController: controllerSDate,
        endDateController: controllerEDate,
      ),
      controllers: EducationControllers(
        school: controllerSchool,
        degree: controllerDegree,
        fieldOfStudy: controllerFieldOfStudy,
        startDate: controllerSDate,
        endDate: controllerEDate,
      ),
    );

    setState(() {
      educationWidgetsData.add(data);
    });
  }

/*
  Widget WorkWidget(
    TextEditingController companyNameController,
    TextEditingController jobTitleController,
    TextEditingController taxIDController,
    TextEditingController ibanController,
  ) {
    return Column(
      children: [
        _TextFormFields("Company Name", "Enter your company name",
            companyNameController, TextInputType.name),
        _TextFormFields("Job Title", "Enter your job title", jobTitleController,
            TextInputType.name),
        _TextFormFields(
            "Tax ID", "Enter your tax ID", taxIDController, TextInputType.name),
        _TextFormFields(
            "IBAN", "Enter your IBAN", ibanController, TextInputType.text),
      ],
    );
  }
*/
/*
  Widget EducationWidget(
    TextEditingController schoolController,
    TextEditingController degreeController,
    TextEditingController fieldOfStudyController,
    TextEditingController startDateController,
    TextEditingController endDateController,
  ) {
    return Column(
      children: [
        _TextFormFields("School", "School", schoolController,
            TextInputType.name),
        _TextFormFields("Degree", "Enter your degree", degreeController,
            TextInputType.name),
        _TextFormFields("Field Of Study", "Enter your department",
            fieldOfStudyController, TextInputType.name),
        _TextFormFields("Starting Date", "Date (DD/MM/YYYY)",
            startDateController, TextInputType.datetime),
        _TextFormFields("Ending Data (or expected)", "Date (DD/MM/YYYY)",
            endDateController, TextInputType.datetime),
      ],
    );
  }
  */
  /*
  Widget _TextFormFields(
      String option,
      String hintText,
      TextEditingController textEditingController,
      TextInputType textInputType) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              option,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Constants.primaryColorDarker,
                fontSize: Constants.responsiveFlex(
                            MediaQuery.of(context).size.width) >
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
              controller: textEditingController,
              keyboardType: textInputType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0x7F040658),
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.8,
                    strokeAlign: BorderSide.strokeAlignInside,
                    color: Constants.primaryColorDarker,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.8,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Constants.primaryColorDarker,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onEditingComplete: () => _focusNodePassword.requestFocus(),
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return "Please enter your first name.";
              //   }
              //   return null;
              // },
            ),
          ],
        ),
      ),
    );
  }
  */
}

// Work widget classes
/*
class WorkWidgetData {
  final Widget workWidget;
  final WorkControllers controllers;

  WorkWidgetData({
    required this.workWidget,
    required this.controllers,
  });
}

class WorkControllers {
  final TextEditingController companyName;
  final TextEditingController jobTitle;
  final TextEditingController taxID;
  final TextEditingController iban;

  WorkControllers({
    required this.companyName,
    required this.jobTitle,
    required this.taxID,
    required this.iban,
  });
}
*/
// Education Widget classes

/*
class EducationWidgetData {
  final Widget educationWidget;
  final EducationControllers controllers;

  EducationWidgetData({
    required this.educationWidget,
    required this.controllers,
  });
}

class EducationControllers {
  final TextEditingController school;
  final TextEditingController degree;
  final TextEditingController fieldOfStudy;
  final TextEditingController startDate;
  final TextEditingController endDate;

  EducationControllers({
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
  });
}
*/
