import 'dart:io';
import 'dart:math';

import 'package:digital_nfc_card/Datas/EducationInformation.dart';
import 'package:digital_nfc_card/Datas/LinkInformation.dart';
import 'package:digital_nfc_card/Datas/WorkInformation.dart';
import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsLinksScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/VisibleProfileScreen.dart';
import 'package:digital_nfc_card/Services/TokenStorageService.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int currentIndex = 0;

  String profileName = "";
  String profileTitle = "";
  String profileDescription = "";

  // SocialMedia Information
  List<SocialMedia> socialMediaList = [];

  // List Information
  List<Link> linkList = [];

  // Contact Information
  List<List<Information>> contactInformationLists = [];

  // Work Information
  List<List<Information>> workInformationLists = [];

  // Education Information
  List<List<Information>> educationInformationLists = [];

  File? image;

  @override
  Widget build(BuildContext context) {
    var userDataProvider = Provider.of<UserDataProvider>(context);
    setProfileInformation();
    socialMediaList = setSocialMedias();
    contactInformationLists = setContactInformation();
    workInformationLists = setWorkInformation();
    educationInformationLists = setEducationInformation();
    linkList = setLinks();
    image = userDataProvider.userData.image;

    // // Listen for changes in the provider
    // Provider.of<UserDataProvider>(context, listen: false).addListener(() {
    //   setState(() {
    //     socialMediaList = setSocialMedias(context);
    //   });
    // });

    double appBarHeightMultiplier = 0.08;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    EdgeInsets padding = MediaQuery.of(context).padding;

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return VisibleProfileScreen(null, null);
                          },
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.visibility_rounded,
                      size: 26,
                      color: Constants.primaryColorDarker,
                    ),
                  ),
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
                              ? 22
                              : 18,
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
                              ? 18
                              : 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SettingsScreen();
                          },
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.settings_rounded,
                      size: 26,
                      color: Constants.primaryColorDarker,
                    ),
                  ),
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      top: 26,
                    ),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const ShapeDecoration(
                                  color: Color(0x7FB5B5B5),
                                  shape: CircleBorder(
                                    side: BorderSide(
                                      width: 3,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                      color: Color(0xFFFBFBFB),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: image == null
                                      ? Icon(
                                          Icons.add_photo_alternate,
                                          size: 24,
                                          color: Constants.primaryColorDarker,
                                        )
                                      : CircleAvatar(
                                          backgroundImage: FileImage(image!),
                                          radius:
                                              50, // Adjust the radius as needed
                                        ),
                                ),
                              ),
                              SizedBox(
                                  height: Constants.responsiveFlex(
                                              MediaQuery.of(context)
                                                  .size
                                                  .width) >
                                          0
                                      ? 36
                                      : 24),
                              if (profileName != "")
                                Text(
                                  profileName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.primaryColorDarker,
                                    fontSize: 26,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              if (profileTitle.isNotEmpty)
                                SizedBox(
                                    height: Constants.responsiveFlex(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) >
                                            0
                                        ? 16
                                        : 10),
                              if (profileTitle.isNotEmpty)
                                Text(
                                  profileTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.primaryColorDarker,
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              if (profileDescription.isNotEmpty)
                                SizedBox(
                                    height: Constants.responsiveFlex(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) >
                                            0
                                        ? 16
                                        : 10),
                              if (profileDescription.isNotEmpty)
                                Text(
                                  profileDescription,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.primaryColorDarker,
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              if (socialMediaList.isNotEmpty)
                                SizedBox(
                                    height: Constants.responsiveFlex(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) >
                                            0
                                        ? 24
                                        : 20),
                              socialMediaList.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 10.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "Social Media",
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
                                            height: 0,
                                            letterSpacing: 0.02,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Wrap(
                                            spacing: Constants.responsiveFlex(
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width) >
                                                    0
                                                ? 16
                                                : 8,
                                            children: List.generate(
                                              min(socialMediaList.length,
                                                  6), // Show up to 6 images in the first row
                                              (index) => SizedBox(
                                                width: 36,
                                                height: 36,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      launchUrl(
                                                          //TODO: xd
                                                          // Uri.parse(
                                                          //     "atlasspace://card/"),
                                                          // mode: LaunchMode
                                                          //     .externalApplication,
                                                          Uri.parse(
                                                              socialMediaList[
                                                                          index]
                                                                      .baseUrl +
                                                                  socialMediaList[
                                                                          index]
                                                                      .userName),
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    },
                                                    icon: Image.asset(
                                                        socialMediaList[index]
                                                            .iconPath,
                                                        color: Constants.primaryColorDarker,
                                                        width: 24),
                                                    // child:
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                              height:
                                                  10), // Adjust the spacing between rows
                                          if (socialMediaList.length > 6)
                                            Wrap(
                                              spacing: Constants.responsiveFlex(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width) >
                                                      0
                                                  ? 16
                                                  : 10,
                                              children: List.generate(
                                                max(
                                                    0,
                                                    socialMediaList.length -
                                                        6), // Show the remaining images in the second row
                                                (index) => SizedBox(
                                                  width: 36,
                                                  height: 36,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                        socialMediaList[
                                                                index + 6]
                                                            .iconPath,
                                                        color: Constants.primaryColorDarker,
                                                        width: 24),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                              SizedBox(
                                  height: Constants.responsiveFlex(
                                              MediaQuery.of(context)
                                                  .size
                                                  .width) >
                                          0
                                      ? 24
                                      : 18),
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 12,
                                  right: 12,
                                  bottom: 10,
                                ),
                                decoration: ShapeDecoration(
                                  color: Constants.primaryBgColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                alignment: Alignment.center),
                                            onPressed: () {
                                              setState(() {
                                                if (currentIndex != 0) {
                                                  currentIndex = 0;
                                                  // _pageController.previousPage(
                                                  //     duration: const Duration(
                                                  //         milliseconds: 100),
                                                  //     curve: Curves.easeIn);
                                                }
                                              });
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 26,
                                                  color: currentIndex == 0
                                                      ? Constants.primaryColorDarker
                                                      : Constants.primaryColorLighter,
                                                ),
                                                Text(
                                                  'Profile',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: currentIndex == 0
                                                        ? Constants.primaryColorDarker
                                                        : Constants.primaryColorLighter,
                                                    fontSize: 16,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                                if (currentIndex == 0)
                                                  SizedBox(
                                                      height: Constants.responsiveFlex(
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) >
                                                              0
                                                          ? 24
                                                          : 5),
                                                if (currentIndex == 0)
                                                  Container(
                                                    width: 34,
                                                    height: 4,
                                                    decoration:
                                                        ShapeDecoration(
                                                      color: Constants.primaryColorDarker,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  100),
                                                          topRight:
                                                              Radius.circular(
                                                                  100),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                alignment: Alignment.center),
                                            onPressed: () {
                                              setState(() {
                                                if (currentIndex != 1) {
                                                  currentIndex = 1;
                                                  // _pageController.nextPage(
                                                  //     duration: const Duration(
                                                  //         milliseconds: 100),
                                                  //     curve: Curves.easeIn);
                                                }
                                              });
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.link_rounded,
                                                  size: 26,
                                                  color: currentIndex == 1
                                                      ? Constants.primaryColorDarker
                                                      : Constants.primaryColorLighter,
                                                ),
                                                Text(
                                                  'Links',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: currentIndex == 1
                                                        ? Constants.primaryColorDarker
                                                        : Constants.primaryColorLighter,
                                                    fontSize: 16,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                                if (currentIndex == 1)
                                                  SizedBox(
                                                      height: Constants.responsiveFlex(
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) >
                                                              0
                                                          ? 24
                                                          : 5),
                                                if (currentIndex == 1)
                                                  Container(
                                                    width: 34,
                                                    height: 4,
                                                    decoration:
                                                        ShapeDecoration(
                                                      color: Constants.primaryColorDarker,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  100),
                                                          topRight:
                                                              Radius.circular(
                                                                  100),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 2, height: 2),
                                    // if(contactInformationList.isNotEmpty && workInformationList.isEmpty && educationInformationList.isEmpty)
                                    if (contactInformationLists.isEmpty &&
                                        workInformationLists.isEmpty &&
                                        educationInformationLists.isEmpty &&
                                        currentIndex == 0) ...[
                                      SizedBox(
                                          height: Constants.responsiveFlex(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width) >
                                                  0
                                              ? 30
                                              : 24),
                                      Text(
                                        "Contact",
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Constants.primaryColorDarker,
                                          fontSize: 18,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                          height: Constants.responsiveFlex(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width) >
                                                  0
                                              ? 30
                                              : 24),
                                      Text(
                                        "Work",
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Constants.primaryColorDarker,
                                          fontSize: 18,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                          height: Constants.responsiveFlex(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width) >
                                                  0
                                              ? 30
                                              : 24),
                                      Text(
                                        "Education",
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Constants.primaryColorDarker,
                                          fontSize: 18,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ] else if (contactInformationLists
                                            .isNotEmpty &&
                                        currentIndex == 0) ...[
                                      const SizedBox(height: 10),
                                      ProfileInformations(
                                          "Contact", contactInformationLists),
                                    ] else if (currentIndex == 1) ...[
                                      linkList.isNotEmpty
                                          ? LinkInformations(linkList)
                                          : Column(
                                              children: [
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  'There is no link you have created yet...',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Constants.primaryColorDarker,
                                                    fontSize: 18,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: screenHeight / 10,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return const SettingsLinksScreen();
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(const Size(
                                                                double.infinity,
                                                                44)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith<
                                                                Color>((Set<
                                                                    MaterialState>
                                                                states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .hovered)) {
                                                        return Constants
                                                            .primaryHoverColor;
                                                      } else {
                                                        return Constants
                                                            .primaryColor;
                                                      }
                                                    }),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Add a Link',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFFFBFBFB),
                                                      fontSize: 18,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0.09,
                                                      letterSpacing: 0.02,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ] else
                                      ...[],
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  if (currentIndex == 0) ...[
                                    const SizedBox(height: 10),
                                    if (workInformationLists.isNotEmpty) ...{
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 12,
                                          right: 12,
                                          bottom: 10,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: Constants.primaryBgColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: ProfileInformations(
                                            "Work", workInformationLists),
                                      ),
                                    },
                                    const SizedBox(height: 10),
                                    if (educationInformationLists
                                        .isNotEmpty) ...{
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 12,
                                          right: 12,
                                          bottom: 10,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: Constants.primaryBgColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: ProfileInformations("Education",
                                            educationInformationLists),
                                      ),
                                    },
                                  ],
                                  // const SizedBox(height: 18),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: Constants.responsiveFlex(
                                        MediaQuery.of(context).size.width) >
                                    0
                                ? 24
                                : 10),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              _showQRDialog(
                                  this.context, Icons.qr_code_2_rounded);
                            },
                            icon: Icon(
                              Icons.qr_code_2_rounded,
                              size: 26,
                              color: Constants.primaryColorDarker,
                            ),
                          ),
                        ),
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
      ),
    );
  }

  // Set Profile Information depends on the user's profile information
  void setProfileInformation() {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    profileName =
        "${userDataProvider.userData.firstName} ${userDataProvider.userData.lastName}";
    profileTitle = userDataProvider.userData.title;
    profileDescription = userDataProvider.userData.aboutYou;
  }

  // Set Social Medias depends on the user's social medias
  List<SocialMedia> setSocialMedias() {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    List<SocialMedia> socialMediaList = userDataProvider
        .userData.socialMediaList.entries
        .map((entry) => SocialMedia(entry.key, entry.value,
            getIconPath(entry.key), getBaseUrl(entry.key)))
        .toList();

    return socialMediaList;
  }

  String getBaseUrl(String name) {
    switch (name) {
      case "Facebook":
        return "https://www.facebook.com/";
      case "X":
        return "https://twitter.com/";
      case "Instagram":
        return "https://www.instagram.com/";
      case "Linkedin":
        return "https://www.linkedin.com/in/";
      case "Discord":
        return "https://discord.com/users/";
      case "Behance":
        return "https://www.behance.net/";
      case "Twitch":
        return "https://www.twitch.tv/";
      case "Website":
        return "";
      case "Tiktok":
        return "https://www.tiktok.com/@";
      case "Dribbble":
        return "https://dribbble.com/";
      case "Threads":
        return "https://threads.com/";
      default:
        return ""; // Placeholder for unknown platforms
    }
  }

  String getIconPath(String name) {
    switch (name) {
      case "Facebook":
        return "assets/icons/facebook.png";
      case "X":
        return "assets/icons/x.png";
      case "Instagram":
        return "assets/icons/instagram.png";
      case "Linkedin":
        return "assets/icons/linkedin.png";
      case "Discord":
        return "assets/icons/discord.png";
      case "Behance":
        return "assets/icons/behance.png";
      case "Twitch":
        return "assets/icons/twitch.png";
      case "Website":
        return "assets/icons/web.png";
      case "Tiktok":
        return "assets/icons/tiktok.png";
      case "Dribbble":
        return "assets/icons/dribbble.png";
      case "Threads":
        return "assets/icons/threads.png";
      default:
        return "assets/icons/default_icon.png"; // Placeholder for unknown platforms
    }
  }

  // Set Contact depends on the user's contact information
  List<List<Information>> setContactInformation() {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    return  [
      if ((userDataProvider.userData.phoneNumber != "") || (userDataProvider.userData.contactEmail != "") || (userDataProvider.userData.website != "")) ...{
        [
          if (userDataProvider.userData.phoneNumber != "") ...{
            Information("Phone Number", userDataProvider.userData.phoneNumber,
                "assets/icons/phone.png"),
          },
          if (userDataProvider.userData.contactEmail != "") ...{
            Information("E-mail Address", userDataProvider.userData.contactEmail,
                "assets/icons/message.png"),
          },
          if (userDataProvider.userData.website != "") ...{
            Information("Website", userDataProvider.userData.website,
                "assets/icons/website.png"),
          },
        ],
      }
    ];
  }

  // Set Works depends on the user's works
  List<List<Information>> setWorkInformation() {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);

    List<WorkInformation> workInformationList =
        userDataProvider.userData.workInformationList;
    return workInformationList
        .map((workInfo) => [
              Information(
                "${workInfo.jobTitle} ",
                "at ${workInfo.companyName}", // Assuming a fixed date format
                "assets/icons/location.png",
              ),
              if (workInfo.taxId != null && workInfo.taxId != "")
                Information(
                    "Tax ID", workInfo.taxId!, "assets/icons/website.png"),
              if (workInfo.iban != null && workInfo.iban != "")
                Information("IBAN", workInfo.iban!, "assets/icons/website.png"),
            ])
        .toList();
  }

  // Set Educations depends on the user's educations
  List<List<Information>> setEducationInformation() {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    List<EducationInformation> educationInformationList =
        userDataProvider.userData.educationInformationList;
    return educationInformationList
        .map((educationInfo) => [
              Information(
                "${educationInfo.fieldOfStudy} at ${educationInfo.schoolName}",
                "${educationInfo.degree} ${educationInfo.startingDate}-${educationInfo.endingDate}",
                "assets/icons/book.png",
              ),
            ])
        .toList();
  }

  // Set Links depends on the user's links
  List<Link> setLinks() {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    List<LinkInformation> linkInformationList =
        userDataProvider.userData.linkInformationList;
    return linkInformationList
        .map((linkInfo) => Link(linkInfo.name, linkInfo.url))
        .toList();
  }

  void _showQRDialog(BuildContext context, IconData iconData) async {
    final String? userId = await TokenStorageService.getId();
    if (!context.mounted) return;
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20,), 
                QrImageView(
                  data: userId != null
                      ? "${Constants.baseProfileUrl}$userId/${Provider.of<UserDataProvider>(context, listen: false).userData.cardInformation.idNumber == "" ? "159753" : Provider.of<UserDataProvider>(context, listen: false).userData.cardInformation.idNumber}"
                      : "",
                  size: MediaQuery.of(context).size.width * 0.75,
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Constants.primaryColorDarker,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Constants.primaryColorDarker,
                  ),
                  // Constants.primaryColorDarker,
                ),    
                const SizedBox(height: 20,),        
                Text(
                  Constants.poweredBy,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Constants.primaryColorDarker,
                    fontSize: Constants.responsiveFlex(
                                MediaQuery.of(context).size.width) >
                            0
                        ? 20
                        : 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class InformationBox extends StatelessWidget {
  final String name;
  final String detail;
  final String iconPath;

  const InformationBox(this.name, this.detail, this.iconPath, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        // color: Colors.amber,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  iconPath,
                  width: Constants.responsiveFlex(
                              MediaQuery.of(context).size.width) >
                          0
                      ? 20
                      : 18,
                  color: Constants.primaryColorDarker,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            letterSpacing: 0.02,
                          ),
                        ),
                      ),
                      Text(
                        softWrap: true,
                        detail,
                        style: TextStyle(
                          color: Constants.primaryColorLighter,
                          fontSize: Constants.responsiveFlex(
                                      MediaQuery.of(context).size.width) >
                                  0
                              ? 18
                              : 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInformations extends StatelessWidget {
  final List<List<Information>> informationLists;
  final String infoName;

  const ProfileInformations(this.infoName, this.informationLists, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            infoName,
            softWrap: true,
            style: TextStyle(
              color: Constants.primaryColorDarker,
              fontSize: 18,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
            textAlign: TextAlign.start,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: informationLists.length,
            itemBuilder: (BuildContext context, int index) {
              List<Information> informationList = informationLists[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index > 0) ...[
                    const SizedBox(height: 5),
                    const Divider(thickness: 2, height: 2),
                    const SizedBox(height: 5),
                  ],
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: informationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Information info = informationList[index];
                      return InformationBox(
                          info.name, info.detail, info.iconPath);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class Information {
  final String name;
  final String detail;
  final String iconPath;

  Information(this.name, this.detail, this.iconPath);
}

class SocialMedia {
  final String name;
  final String userName;
  final String iconPath;
  final String baseUrl;

  SocialMedia(this.name, this.userName, this.iconPath, this.baseUrl);
}

class Link {
  final String name;
  final String url;

  Link(this.name, this.url);
}

class LinkInformations extends StatelessWidget {
  final List<Link> linkList;
  // final String infoName;

  const LinkInformations(this.linkList, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [
          // const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: linkList.length,
            itemBuilder: (BuildContext context, int index) {
              Link info = linkList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(linkList[index].url),
                        mode: LaunchMode.externalApplication);
                  },
                  child: Text(
                    info.name,
                    textAlign: TextAlign.center,
                    softWrap: true,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
