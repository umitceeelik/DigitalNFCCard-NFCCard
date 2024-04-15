import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Services/TokenStorageService.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class SettingsLinksScreen extends StatefulWidget {
  const SettingsLinksScreen({super.key});

  @override
  State<SettingsLinksScreen> createState() => _SettingsLinksScreenState();
}

class _SettingsLinksScreenState extends State<SettingsLinksScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerWebsite = TextEditingController();

  final bool _obscurePassword = true;

  List<LinkBox> linkList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLinks();
  }

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
                  onPressed: () async {
                    print("Saving new values!!!");
                    saveNewValues();
                    Navigator.pop(context);
                  },
                  icon: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 26,
                      color: Constants.primaryColorDarker,
                    ),
                  ),
                ),
                const Text(
                  'Links',
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
            fontSize: Constants.responsiveFlex(screenWidth) > 0 ? 30 : 20,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (linkList.isEmpty) ...[
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Transform(
                                          transform: Matrix4.identity()
                                            ..translate(-15.0, 10.0)
                                            ..rotateZ(-0.8),
                                          child: Icon(
                                            Icons.link_rounded,
                                            color: Constants.primaryColorDarker,
                                            size: 60,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'No links added yet...',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Constants.primaryColorDarker,
                                            fontSize: 22,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Please add a link, if you have one. ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Constants.primaryColorDarker,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ] else ...[
                                  Text(
                                    'My Links',
                                    style: TextStyle(
                                      color: Constants.primaryColorDarker,
                                      fontSize: 20,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ...linkList,
                                ]
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
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
                        onPressed: () => _navigateToAddLinkPage(context),
                        child: const Text(
                          'Add a New Link',
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

  // Set Links depends on the user's links
  void setLinks() {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    linkList.clear();
    for (var linkInfo in userDataProvider.userData.linkInformationList) {
      AddNewLink(linkInfo.name, linkInfo.url);
    }
  }

  void AddNewLink(String linkName, String linkDetail) {
    setState(() {
      linkList.add(LinkBox(linkName, linkDetail, RemoveLink));
    });
  }

  void RemoveLink(LinkBox context) {
    setState(() {
      linkList.remove(context);
    });
  }

  Future<void> _navigateToAddLinkPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddLinkPage(
                onSavePressed: saveNewValues2,
              )),
    );
  }

  Future<dynamic> saveNewValues2(String name, String description) async {
    AddNewLink(name, description);

    print("Saving new values...");
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    bool isChanged = false;

    // If 2 lists are empty, return
    if (linkList.isEmpty &&
        userDataProvider.userData.linkInformationList.isEmpty) {
      print("No changed");
      return;
    }

    // If 2 lists' length are different, return
    if (linkList.length !=
        userDataProvider.userData.linkInformationList.length) {
      isChanged = true;
    } else {
      // If 2 lists' length are same, check if there is any change
      for (var linkBox in linkList) {
        if (linkBox.name !=
                userDataProvider.userData
                    .linkInformationList[linkList.indexOf(linkBox)].name ||
            linkBox.detail !=
                userDataProvider.userData
                    .linkInformationList[linkList.indexOf(linkBox)].url) {
          isChanged = true;
          break;
        }
      }
    }

    // If there is no change, return
    if (!isChanged) {
      print("No changed");
      return;
    }
    print("Changed");
    userDataProvider.clearLinkInformation();

    for (var linkBox in linkList) {
      userDataProvider.addLinkInformation(linkBox.name, linkBox.detail);
    }
    String? id = await TokenStorageService.getId();
    await userDataProvider.saveUserData(id, context);
  }

  Future<dynamic> saveNewValues() async {
    print("Saving new values...");
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    bool isChanged = false;

    // If 2 lists are empty, return
    if (linkList.isEmpty &&
        userDataProvider.userData.linkInformationList.isEmpty) {
      print("No changed");
      return;
    }

    // If 2 lists' length are different, return
    if (linkList.length !=
        userDataProvider.userData.linkInformationList.length) {
      isChanged = true;
    } else {
      // If 2 lists' length are same, check if there is any change
      for (var linkBox in linkList) {
        if (linkBox.name !=
                userDataProvider.userData
                    .linkInformationList[linkList.indexOf(linkBox)].name ||
            linkBox.detail !=
                userDataProvider.userData
                    .linkInformationList[linkList.indexOf(linkBox)].url) {
          isChanged = true;
          print("asdfasd");
          break;
        }
      }
    }

    // If there is no change, return
    if (!isChanged) {
      print("No changed");
      return;
    }
    print("Changed");
    userDataProvider.clearLinkInformation();

    for (var linkBox in linkList) {
      print("Adding linkbox ${linkBox.name}");
      userDataProvider.addLinkInformation(linkBox.name, linkBox.detail);
    }
    String? id = await TokenStorageService.getId();
    await userDataProvider.saveUserData(id, context);
  }
}

class LinkBox extends StatelessWidget {
  final String name;
  final String detail;
  final Function(LinkBox) onPressed;

  const LinkBox(this.name, this.detail, this.onPressed, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      child: Container(
        // color: Colors.amber,
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.link_rounded,
                  size: Constants.responsiveFlex(
                              MediaQuery.of(context).size.width) >
                          0
                      ? 34
                      : 24,
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
                            color: Constants.primaryColorLighter,
                            fontSize: Constants.responsiveFlex(
                                        MediaQuery.of(context).size.width) >
                                    0
                                ? 18
                                : 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => onPressed(this),
                  icon: Icon(
                    Icons.delete_rounded,
                    size: Constants.responsiveFlex(
                                MediaQuery.of(context).size.width) >
                            0
                        ? 34
                        : 24,
                    color: Constants.primaryColorDarker,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  final Function(String) onOptionSelected;

  const BottomSheetContent({super.key, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 32.0,
          right: 32.0,
          top: Constants.responsiveFlex(MediaQuery.of(context).size.width) > 0
              ? 60
              : 16,
          bottom:
              Constants.responsiveFlex(MediaQuery.of(context).size.width) > 0
                  ? 60
                  : 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SM_ListTile(context, "assets/icons/facebook.png", 'Facebook'),
          SM_ListTile(context, "assets/icons/x.png", 'X'),
          SM_ListTile(context, "assets/icons/instagram.png", 'Instagram'),
          SM_ListTile(context, "assets/icons/linkedin.png", 'Linkedin'),
          SM_ListTile(context, "assets/icons/discord.png", 'Discord'),
          SM_ListTile(context, "assets/icons/behance.png", 'Behance'),
          SM_ListTile(context, "assets/icons/twitch.png", 'Twitch'),
          SM_ListTile(context, "assets/icons/web.png", 'Website'),
          SM_ListTile(context, "assets/icons/tiktok.png", 'Tiktok'),
          SM_ListTile(context, "assets/icons/dribbble.png", 'Dribbble'),
          SM_ListTile(context, "assets/icons/threads.png", 'Threads'),
        ],
      ),
    );
  }

  //Create the ListTile for popup.
  ListTile SM_ListTile(
      BuildContext context, String iconPath, String titleText) {
    return ListTile(
      leading: Image.asset(iconPath,
          // color: Constants.primaryColorDarker,
          width: 20),
      title: Text(
        titleText,
        style: TextStyle(
          color: Constants.primaryColorDarker,
          fontSize: 18,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          height: 0.09,
          letterSpacing: 0.02,
        ),
      ),
      onTap: () {
        onOptionSelected(titleText);
        Navigator.pop(context);
      },
    );
  }
}

class AddLinkPage extends StatelessWidget {
  final Future<dynamic> Function(String, String) onSavePressed;
  final TextEditingController linkNameController = TextEditingController();
  final TextEditingController linkDescriptionController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  AddLinkPage({super.key, required this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    double appBarHeightMultiplier = 0.08;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    EdgeInsets padding = MediaQuery.of(context).padding;

    return Scaffold(
      appBar: AppBar(
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
                'Links',
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
              Constants.responsiveFlex(MediaQuery.of(context).size.width) > 0
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Links Title',
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
                                    controller: linkNameController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText:
                                          "Add a description for the link",
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
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.8,
                                          strokeAlign:
                                              BorderSide.strokeAlignInside,
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
                                        return "Please add a description for the link.";
                                      }
                                      return null;
                                      // else if (!_boxAccounts.containsKey(value)) {
                                      //   return "Username is not registered.";
                                      // }
                                      // return null;
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
                                    'URL',
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
                                    controller: linkDescriptionController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "Add a URL",
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
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.8,
                                          strokeAlign:
                                              BorderSide.strokeAlignInside,
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
                                        return "Please add a URL.";
                                      }
                                      return null;
                                      // else if (!_boxAccounts.containsKey(value)) {
                                      //   return "Username is not registered.";
                                      // }
                                      // return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
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
                                minimumSize: MaterialStateProperty.all(
                                    const Size(71, 45)),
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
                                // Save button
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  onSavePressed.call(linkNameController.text,
                                      linkDescriptionController.text);
                                  Navigator.pop(context, {
                                    'name': linkNameController.text,
                                    'description':
                                        linkDescriptionController.text,
                                  });
                                }
                              },
                              child: const Text(
                                'Save',
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
                      ],
                    ),
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
    );
  }
}
