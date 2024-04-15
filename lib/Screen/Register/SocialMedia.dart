import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Register/ContactInformation.dart';
import 'package:digital_nfc_card/Screen/Register/NFCCardIdentity.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenScreenState();
}

class _SocialMediaScreenScreenState extends State<SocialMediaScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controllerFacebook = TextEditingController();
  final FocusNode _focusNodeFacebook = FocusNode();
  final TextEditingController _controllerX = TextEditingController();
  final FocusNode _focusNodeX = FocusNode();
  final TextEditingController _controllerInstagram = TextEditingController();
  final FocusNode _focusNodeInstagram = FocusNode();
  final TextEditingController _controllerLinkedin = TextEditingController();
  final FocusNode _focusNodeLinkedin = FocusNode();
  final TextEditingController _controllerDiscord = TextEditingController();
  final FocusNode _focusNodeDiscord = FocusNode();
  final TextEditingController _controllerBehance = TextEditingController();
  final FocusNode _focusNodeBehance = FocusNode();
  final TextEditingController _controllerTwitch = TextEditingController();
  final FocusNode _focusNodeTwitch = FocusNode();
  final TextEditingController _controllerWebsite = TextEditingController();
  final FocusNode _focusNodeWebsite = FocusNode();
  final TextEditingController _controllerTiktok = TextEditingController();
  final FocusNode _focusNodeTiktok = FocusNode();
  final TextEditingController _controllerDribbble = TextEditingController();
  final FocusNode _focusNodeDribbble = FocusNode();
  final TextEditingController _controllerThreads = TextEditingController();
  final FocusNode _focusNodeThreads = FocusNode();

  bool _isActiveFacebook = false;
  bool _isActiveX = false;
  bool _isActiveInstagram = false;
  bool _isActiveLinkedin = false;
  bool _isActiveDiscord = false;
  bool _isActiveBehance = false;
  bool _isActiveTwitch = false;
  bool _isActiveWebsite = false;
  bool _isActiveTiktok = false;
  bool _isActiveDribbble = false;
  bool _isActiveThreads = false;

  int addedSocialMediaCount = 0;
  int totalSocialMediaCount = 11;
  List<Widget> textFieldsList = [];

  Map<String, String> socialMediaList = {};
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
            fontSize:
                Constants.responsiveFlex(MediaQuery.of(context).size.width) > 0
                    ? 30
                    : 20,
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
                                  Icons.favorite,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'Step 2/6',
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
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'Social Media',
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
                              value: 2 / 6,
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
                                if (_isActiveFacebook)
                                  SM_TextFormFields("Facebook", "Enter your username",
                                      "assets/icons/facebook.png", _controllerFacebook),
                                if (_isActiveX)
                                  SM_TextFormFields("X", "Enter your username",
                                      "assets/icons/x.png", _controllerX),
                                if (_isActiveInstagram)
                                  SM_TextFormFields("Instagram", "Enter your username",
                                      "assets/icons/instagram.png", _controllerInstagram),
                                if (_isActiveLinkedin)
                                  SM_TextFormFields("Linkedin", "Enter your username",
                                      "assets/icons/linkedin.png", _controllerLinkedin),
                                if (_isActiveDiscord)
                                  SM_TextFormFields("Discord", "Enter your discord user id",
                                      "assets/icons/discord.png", _controllerDiscord),
                                if (_isActiveBehance)
                                  SM_TextFormFields("Behance", "Enter your username",
                                      "assets/icons/behance.png", _controllerBehance),
                                if (_isActiveTwitch)
                                  SM_TextFormFields("Twitch", "Enter your username",
                                      "assets/icons/twitch.png", _controllerTwitch),
                                if (_isActiveWebsite)
                                  SM_TextFormFields("Website", "Enter your website",
                                      "assets/icons/web.png", _controllerWebsite),
                                if (_isActiveTiktok)
                                  SM_TextFormFields("Tiktok", "Enter your username",
                                      "assets/icons/tiktok.png", _controllerTiktok),
                                if (_isActiveDribbble)
                                  SM_TextFormFields(
                                      "Dribbble",
                                      "jessicajoe",
                                      "assets/icons/dribbble.png",
                                      _controllerDribbble),
                                if (_isActiveThreads)
                                  SM_TextFormFields(
                                      "Threads",
                                      "jessicajoe",
                                      "assets/icons/threads.png",
                                      _controllerThreads),
                                const SizedBox(height: 40),
                                if (totalSocialMediaCount >
                                    addedSocialMediaCount)
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
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.hovered)) {
                                            return Constants.primaryHoverColor;
                                          } else {
                                            return Constants.primaryBgColor;
                                          }
                                        }),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                              color: Constants.primaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return BottomSheetContent(
                                              onOptionSelected:
                                                  (String option) {
                                                _handleOptionSelected(option);
                                              },
                                            );
                                          },
                                        );
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
                                            ' Add Social Media',
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
                              _formKey.currentState?.reset();
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
                                          listen: false).clearSocialMedia();
                                for (var key in socialMediaList.keys) {
                                  switch (key) {
                                    case "Facebook":
                                      _isActiveFacebook = true;
                                      socialMediaList["Facebook"] =
                                          _controllerFacebook.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerFacebook.text);
                                      break;
                                    case "X":
                                      _isActiveX = true;
                                      socialMediaList["X"] =
                                          _controllerX.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerX.text);
                                      break;
                                    case "Instagram":
                                      _isActiveInstagram = true;
                                      socialMediaList["Instagram"] =
                                          _controllerInstagram.text;
                                        Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerInstagram.text);
                                      break;
                                    case "Linkedin":
                                      _isActiveLinkedin = true;
                                      socialMediaList["Linkedin"] =
                                          _controllerLinkedin.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerLinkedin.text);
                                      break;
                                    case "Discord":
                                      _isActiveDiscord = true;
                                      socialMediaList["Discord"] =
                                          _controllerDiscord.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerDiscord.text);
                                      break;
                                    case "Behance":
                                      _isActiveBehance = true;
                                      socialMediaList["Behance"] =
                                          _controllerBehance.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerBehance.text);          
                                      break;
                                    case "Twitch":
                                      _isActiveTwitch = true;
                                      socialMediaList["Twitch"] =
                                          _controllerTwitch.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerTwitch.text);
                                      break;
                                    case "Website":
                                      _isActiveWebsite = true;
                                      socialMediaList["Website"] =
                                          _controllerWebsite.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerWebsite.text);
                                      break;
                                    case "Tiktok":
                                      _isActiveTiktok = true;
                                      socialMediaList["Tiktok"] =
                                          _controllerTiktok.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerTiktok.text);
                                      break;
                                    case "Dribbble":
                                      _isActiveDribbble = true;
                                      socialMediaList["Dribbble"] =
                                          _controllerDribbble.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerDribbble.text);
                                      break;
                                    case "Threads":
                                      _isActiveThreads = true;
                                      socialMediaList["Threads"] =
                                          _controllerThreads.text;
                                      Provider.of<UserDataProvider>(context,
                                          listen: false).addSocialMedia(
                                          key, _controllerThreads.text);
                                      break;
                                    default:
                                  }
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const ContactInformationScreen();
                                    },
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              "Next",
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

  void _handleOptionSelected(String option) {
    // Create a new TextFormField and add it to the list
    setState(() {
      addedSocialMediaCount++;
      switch (option) {
        case "Facebook":
          _isActiveFacebook = true;
          socialMediaList["Facebook"] = _controllerFacebook.text;
          FocusScope.of(context).requestFocus(_focusNodeFacebook);
          break;
        case "X":
          _isActiveX = true;
          socialMediaList["X"] = _controllerX.text;
          FocusScope.of(context).requestFocus(_focusNodeX);
          break;
        case "Instagram":
          _isActiveInstagram = true;
          socialMediaList["Instagram"] = _controllerInstagram.text;
          FocusScope.of(context).requestFocus(_focusNodeInstagram);
          break;
        case "Linkedin":
          _isActiveLinkedin = true;
          socialMediaList["Linkedin"] = _controllerLinkedin.text;
          FocusScope.of(context).requestFocus(_focusNodeLinkedin);
          break;
        case "Discord":
          _isActiveDiscord = true;
          socialMediaList["Discord"] = _controllerDiscord.text;
          FocusScope.of(context).requestFocus(_focusNodeDiscord);
          break;
        case "Behance":
          _isActiveBehance = true;
          socialMediaList["Behance"] = _controllerBehance.text;
          FocusScope.of(context).requestFocus(_focusNodeBehance);
          break;
        case "Twitch":
          _isActiveTwitch = true;
          socialMediaList["Twitch"] = _controllerTwitch.text;
          FocusScope.of(context).requestFocus(_focusNodeTwitch);
          break;
        case "Website":
          _isActiveWebsite = true;
          socialMediaList["Website"] = _controllerWebsite.text;
          FocusScope.of(context).requestFocus(_focusNodeWebsite);
          break;
        case "Tiktok":
          _isActiveTiktok = true;
          socialMediaList["Tiktok"] = _controllerTiktok.text;
          FocusScope.of(context).requestFocus(_focusNodeTiktok);
          break;
        case "Dribbble":
          _isActiveDribbble = true;
          socialMediaList["Dribbble"] = _controllerDribbble.text;
          FocusScope.of(context).requestFocus(_focusNodeDribbble);
          break;
        case "Threads":
          _isActiveThreads = true;
          socialMediaList["Threads"] = _controllerThreads.text;
          FocusScope.of(context).requestFocus(_focusNodeThreads);
          break;
        default:
      }
    });
  }

  void _deleteTextFormField(String option) {
    setState(() {
      addedSocialMediaCount--;
      switch (option) {
        case "Facebook":
          _isActiveFacebook = false;
          socialMediaList.remove("Facebook");
          break;
        case "X":
          _isActiveX = false;
          socialMediaList.remove("X");
          break;
        case "Instagram":
          _isActiveInstagram = false;
          socialMediaList.remove("Instagram");
          break;
        case "Linkedin":
          _isActiveLinkedin = false;
          socialMediaList.remove("Linkedin");
          break;
        case "Discord":
          _isActiveDiscord = false;
          socialMediaList.remove("Discord");
          break;
        case "Behance":
          _isActiveBehance = false;
          socialMediaList.remove("Behance");
          break;
        case "Twitch":
          _isActiveTwitch = false;
          socialMediaList.remove("Twitch");
          break;
        case "Website":
          _isActiveWebsite = false;
          socialMediaList.remove("Website");
          break;
        case "Tiktok":
          _isActiveTiktok = false;
          socialMediaList.remove("Tiktok");
          break;
        case "Dribbble":
          _isActiveDribbble = false;
          socialMediaList.remove("Dribbble");
          break;
        case "Threads":
          _isActiveThreads = false;
          socialMediaList.remove("Threads");
          break;
        default:
      }
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, String option) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.bottomCenter,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text on the left
              Expanded(
                flex: 4,
                child: Text(
                  "Are you sure you want to delete $option?",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Color(0xFF191919),
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        _deleteTextFormField(option);
                      },
                      child: Text(
                        'Yes',
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
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
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
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'No',
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
              )
            ],
          ),
        );
      },
    );
  }

  Widget SM_TextFormFields(String option, String hintText, String iconPath,
      TextEditingController textEditingController) {
    return Padding(
      padding:  const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
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
                letterSpacing: 0.02,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.name,
              style: TextStyle(
                color: Constants.primaryColorDarker,
                fontSize: 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0x7F040658),
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Image.asset(
                    iconPath,
                    color: Constants.primaryColorDarker,
                    width: 24,
                    height: 24,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minHeight: 24,
                  minWidth: 24,
                ),
                suffixIcon: Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: IconButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, option);
                    },
                    icon: Icon(
                      Icons.delete_rounded,
                      size: 24,
                      color: Constants.primaryColorDarker,
                    ),
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
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
                  return "Username cannot be empty.";
                }
                return null;
              },
            ),
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
  ListTile SM_ListTile(BuildContext context, String iconPath, String titleText) {
    return ListTile(
      leading: Image.asset(
        iconPath,
        // color: Constants.primaryColorDarker,
        width: 20
      ),
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
