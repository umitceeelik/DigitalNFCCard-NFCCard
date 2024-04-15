import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';

import 'package:digital_nfc_card/Screen/Login/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double appBarHeightMultiplier = 0.08;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight *
            appBarHeightMultiplier),
        child: AppBar(
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
                flex:
                    Constants.responsiveFlex(MediaQuery.of(context).size.width),
                child: Container(
                    alignment: Alignment.center,
                    color: Constants.backgroundColor)),
            Expanded(
              flex: 5,
              child: SizedBox(
                width: screenWidth,
                height: screenHeight -
                    appBarHeightMultiplier * screenHeight -
                    padding.top -
                    padding.bottom,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        onPageChanged: (int page) {
                          setState(() {
                            currentIndex = page;
                          });
                        },
                        controller: _pageController,
                        children: [
                          CreatePage(
                            image: Constants.responsiveFlex(MediaQuery.of(context).size.width) > 0
                                ? 'assets/images/Intro01Web.png'
                                : 'assets/images/Intro01.png',
                            description: Constants.descriptionOne,
                          ),
                          CreatePage(
                            image: Constants.responsiveFlex(MediaQuery.of(context).size.width) > 0
                                ? 'assets/images/Intro02Web.png'
                                : 'assets/images/Intro02.png',
                            description: Constants.descriptionTwo,
                          ),
                          CreatePage(
                            image: Constants.responsiveFlex(MediaQuery.of(context).size.width) > 0
                                ? 'assets/images/Intro03Web.png'
                                : 'assets/images/Intro03.png',
                            description: Constants.descriptionThree,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width /10, bottom: 20),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth / 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildIndicator(),
                            ),
                            _nextButton(currentIndex == 2),
                          ]),
                    ),
                  ],
                ),
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

      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: _buildIndicator(),
      //               ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon:  _nextButton(currentIndex == 2),
      //     ),
      //   ],
      // ),
    );
  }

  //Extra Widgets
  Widget _nextButton(bool isLast) {
    Color textButtonHoveredColor = Constants.primaryColor;
    return isLast
        ? ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  Constants.responsiveFlex(MediaQuery.of(context).size.width) > 0 ? const EdgeInsetsDirectional.symmetric(horizontal: 35.0, vertical: 20.0) : const EdgeInsets.all(0.0),
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
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
              // Save the flag indicating that onboarding has been shown
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('onboarding_shown', true);
              setState(() {
                if (currentIndex < 2) {
                  currentIndex++;
                  if (currentIndex < 3) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  }
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()));
                }
              });
            },
            child: const Text(
              'Start',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFBFBFB),
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                height: 0.09,
                letterSpacing: 0.02,
              ),
            ),
          )
        : TextButton(
            onPressed: () {
              setState(() {
                if (currentIndex < 2) {
                  currentIndex++;
                  if (currentIndex < 3) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  }
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                }
              });
            },
            onHover: (value) {
              setState(() {
                textButtonHoveredColor = value
                    ? Constants.primaryHoverColor
                    : Constants.primaryColor;
              });
            },
            child: Text('Skip',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textButtonHoveredColor,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                  letterSpacing: 0.02,
                )),
          );
  }

  //Create the indicator decorations widget
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: 10.0,
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: isActive ? Constants.primaryColor : Constants.blackColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

//Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String description;

  const CreatePage({
    super.key,
    required this.image,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          SizedBox(
            child: (MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height && Constants.responsiveFlex(MediaQuery.of(context).size.width) == 0)
                ? Image.asset(image,
                    width: /*kIsWeb ? MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 2.25:*/ MediaQuery.of(context).size.width,
                    fit: BoxFit.contain)
                : Image.asset(
                    image,
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 3,
                    // height: /*kIsWeb ? MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 2.25 :*/ MediaQuery.of(context).size.height
                  ),
          ),
          Padding(
            padding: /*kIsWeb ? EdgeInsetsDirectional.symmetric(horizontal: MediaQuery.of(context).size.width/ 5.1) :*/
                EdgeInsetsDirectional.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.primaryColorDarker,
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
