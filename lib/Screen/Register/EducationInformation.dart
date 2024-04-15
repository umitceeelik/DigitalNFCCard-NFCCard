import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Register/NFCCardIdentity.dart';
import 'package:digital_nfc_card/Screen/Widgets/EducationWidget/EducationControllers.dart';
import 'package:digital_nfc_card/Screen/Widgets/EducationWidget/EducationWidget.dart';
import 'package:digital_nfc_card/Screen/Widgets/EducationWidget/EducationWidgetData.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class EducationInformationScreen extends StatefulWidget {
  const EducationInformationScreen({super.key});

  @override
  State<EducationInformationScreen> createState() =>
      _EducationInformationScreenState();
}

class _EducationInformationScreenState
    extends State<EducationInformationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  List<EducationWidgetData> educationWidgetsData = [];

  int addedEducationCount = 0;

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
                                  Icons.menu_book_rounded,
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
                                          'Step 5/6',
                                          style: TextStyle(
                                            color: Constants.primaryColorLighter,
                                            fontSize: Constants.responsiveFlex(
                                                        MediaQuery.of(context)
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
                                          'Education Information',
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
                              value: 5 / 6,
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
                                                          .remove(data);
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
                                                        color:
                                                            Constants.primaryColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        'Delete',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Constants.primaryColor,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0.09,
                                                          letterSpacing: 0.02,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              const SizedBox(height: 20),
                                              const Divider(
                                                  height: 1,
                                                  thickness: 2.5,
                                                  color: Color(0xFFB4C4D0)),
                                              const SizedBox(height: 10),
                                            ],
                                          ))
                                      .toList(),
                                ),
                                // const SizedBox(height: 40),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      minimumSize: Constants.responsiveFlex(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width) >
                                              0
                                          ? MaterialStateProperty.all(
                                              const Size(300, 44))
                                          : MaterialStateProperty.all(
                                              const Size(double.infinity, 44)),
                                      maximumSize: Constants.responsiveFlex(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width) >
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
                                      addEducationWidget();
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
                                // _boxLogin.put("loginStatus", true);
                                // _boxLogin.put("userName", _controllerUsername.text);

                                print("TEST ${educationWidgetsData.length}");
                                Provider.of<UserDataProvider>(context,
                                        listen: false)
                                    .clearEducationInformation();
                                for (var data in educationWidgetsData) {
                                  Provider.of<UserDataProvider>(context,
                                          listen: false)
                                      .addEducationInformation(
                                          data.controllers.school.text,
                                          data.controllers.degree.text,
                                          data.controllers.fieldOfStudy.text,
                                          data.controllers.startDate.text,
                                          data.controllers.endDate.text);
                                }
                                print(
                                    "TEST2 ${Provider.of<UserDataProvider>(context, listen: false).userData.educationInformationList.length}");

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

  void addEducationWidget() {
    TextEditingController controllerSchool = TextEditingController();
    TextEditingController controllerDegree = TextEditingController();
    TextEditingController controllerFieldOfStudy = TextEditingController();
    TextEditingController controllerSDate = TextEditingController();
    TextEditingController controllerEDate = TextEditingController();

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
}
