// ignore_for_file: use_build_context_synchronously

import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Login/LoginScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsDigitalNFCCardProductsScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:digital_nfc_card/Services/TokenStorageService.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class NFCCardIdentityScreen extends StatefulWidget {
  const NFCCardIdentityScreen({super.key});

  @override
  State<NFCCardIdentityScreen> createState() => _NFCCardIdentityScreenState();
}

class _NFCCardIdentityScreenState extends State<NFCCardIdentityScreen> {
  bool isScanning = false;

  int addedEducationCount = 0;
  String messageToWrite = "Hello, NFC!"; // Replace this with your data to write
  ValueNotifier<dynamic> result = ValueNotifier(null);

  late NfcManager nfcManager;
  @override
  void initState() {
    super.initState();
    // _ndefWrite1();
    Future.delayed(Duration.zero, () {
      showNFCDialog();
    });
  }

  String listToString(List<int> list) {
    // Joining the list elements into a single string
    String joinedString = list.map((e) => e.toString()).join();
    return joinedString;
  }

  Future<void> _ndefWrite1(BuildContext bottomModalContext) async {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    nfcManager = NfcManager.instance;
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    String cardIdentifierString = "";
    String themeRecord = "defaultTheme";

    if (!(await nfcManager.isAvailable()) || kIsWeb) {
      if (userDataProvider.isCreatingMoreCards ||
          userDataProvider.isCreatingFirstCard) {
        userDataProvider.addNewUserData();
      }
      bool response = await userDataProvider.saveUserData(
          await TokenStorageService.getId(), context);

      if (response) {
        print("Stop Session with Success");
        Navigator.pop(bottomModalContext);
        String? token = await TokenStorageService.getToken();
        snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
            SnackBarType.success,
            token != null
                ? 'Profile Created Successfully!'
                : "Profile Created Successfully! Please Login!"));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return token != null
                  ? const SettingsDigitalNFCCardProductsScreen()
                  : const LoginScreen();
            },
          ),
        );
      } else {
        Navigator.pop(bottomModalContext);
        snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
            SnackBarType.error,
            'Profile data could not be saved. Please try again.'));
        print("Error");
      }
      return;
    }

    await nfcManager.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef != null && ndef.cachedMessage != null) {
        themeRecord =
            String.fromCharCodes(ndef.cachedMessage!.records[0].payload)
                .substring(3);
        print(themeRecord);
      }
      //Read Nfc Card Serial Number
      List<int> nfcaIdentifier = isIOS
          ? tag.data["mifare"]["identifier"]
          : tag.data["nfca"]["identifier"];
      cardIdentifierString = listToString(nfcaIdentifier);

      print(cardIdentifierString);
      bool isCardExists = false;
      for (var element in userDataProvider.userDataList) {
        if (element.cardInformation.idNumber == cardIdentifierString) {
          print("Card is already exists");
          isCardExists = true;
          nfcManager.stopSession().then((value) async {
            print("Stop Session with card is already exists");
            Navigator.pop(bottomModalContext);
            showInfoDialog();
          });
          continue;
          //TODO: Show card is exists popup
        }
      }

      if (isCardExists) {
        //TODO: Show card is exists popup
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return const LoginScreen();
        //     },
        //   ),
        // );
        return;
      }

      userDataProvider.addCardInformation(
          "Card ${userDataProvider.userDataList.length + 1}",
          cardIdentifierString);

      userDataProvider.setThemeType(themeRecord);

      // var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        nfcManager.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createUri(Uri.parse(
            "${Constants.baseProfileUrl}${await TokenStorageService.getId()}/$cardIdentifierString")),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        nfcManager.stopSession().then((value) async {
          if (userDataProvider.isCreatingMoreCards ||
              userDataProvider.isCreatingFirstCard) {
            userDataProvider.addNewUserData();
          }
          bool response = await userDataProvider.saveUserData(
              await TokenStorageService.getId(), context);

          if (response) {
            if (kDebugMode) {
              print("Stop Session with Success");
            }
            Navigator.pop(bottomModalContext);
            snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
                SnackBarType.success,
                'Profile Created Successfully! Please Login!'));
            String? token = await TokenStorageService.getToken();
            userDataProvider
                .switchCardIndex(userDataProvider.userDataList.length - 1);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return token != null
                      ? const SettingsDigitalNFCCardProductsScreen()
                      : const LoginScreen();
                },
              ),
            );
          } else {
            Navigator.pop(bottomModalContext);
            snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
                SnackBarType.error,
                'Profile data could not be saved. Please try again.'));
            if (kDebugMode) {
              print("Error");
            }
          }
        });
      } catch (e) {
        result.value = e;
        nfcManager.stopSession(errorMessage: result.value.toString());
        snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
            SnackBarType.error,
            'Profile data could not be saved. Please try again.'));
        if (kDebugMode) {
          print("Stop Session with Error");
        }
        return;
      }
    });
  }

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
                                  Icons.nfc_rounded,
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
                                          'Step 6/6',
                                          style: TextStyle(
                                            color:
                                                Constants.primaryColorLighter,
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
                                          'NFC Card Identity',
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
                              value: 6 / 6,
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
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                              top: Constants.responsiveFlex(
                                          MediaQuery.of(context).size.width) >
                                      0
                                  ? 60
                                  : 27,
                              bottom: Constants.responsiveFlex(
                                          MediaQuery.of(context).size.width) >
                                      0
                                  ? 60
                                  : 48),
                          child: Column(
                            children: [
                              Text(
                                'Add NFC Card to your account',
                                textAlign: TextAlign.center,
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
                              const SizedBox(height: 26),
                              Text(
                                'Place your NFC card on the back of your device to link it to your account, and wait until the process is complete.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Constants.primaryColorDarker,
                                  fontSize: Constants.responsiveFlex(
                                              MediaQuery.of(context)
                                                  .size
                                                  .width) >
                                          0
                                      ? 25
                                      : 19,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                child: (MediaQuery.of(context).size.width <
                                            MediaQuery.of(context)
                                                .size
                                                .height &&
                                        Constants.responsiveFlex(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) ==
                                            0)
                                    ? Image.asset('assets/images/NFC.png',
                                        width: /*kIsWeb ? MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 2.25:*/
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.contain)
                                    : Image.asset(
                                        'assets/images/QR.png',
                                        height: 220,
                                        // height: /*kIsWeb ? MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 2.25 :*/ MediaQuery.of(context).size.height
                                      ),
                              ),
                              // Column(
                              //   children: workWidgetsData
                              //       .map((data) => Column(
                              //             children: [
                              //               data.workWidget,
                              //               const SizedBox(height: 20),
                              //               const Divider(
                              //                   height: 1,
                              //                   thickness: 2.5,
                              //                   color: Color(0xFFB4C4D0)),
                              //               const SizedBox(height: 10),
                              //             ],
                              //           ))
                              //       .toList(),
                              // ),
                              // const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(screenWidth, 44)),
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
                          // if (_formKey.currentState?.validate() ?? false) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) {
                          //         return const EducationInformationScreen();
                          //       },
                          //     ),
                          //   );
                          // }
                          await showNFCDialog().then((value) {
                            nfcManager.stopSession();
                            print("Stop Session with closing the dialog");
                          });
                        },
                        child: const Text(
                          'Define NFC Card',
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

  Future<T?> showNFCDialog<T>() async {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    print(userDataProvider.isCreatingFirstCard);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      useRootNavigator: true,
      isDismissible: false,
      builder: (BuildContext context) {
        _ndefWrite1(context);
        return Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add NFC Card to your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.primaryColorDarker,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.02,
                ),
              ),
              const SizedBox(height: 34),
              Text(
                'Place your NFC card on the back of your device to link it to your account, and wait until the process is complete',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.primaryColorDarker,
                  fontSize: 19,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 34),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 44)),
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
                  userDataProvider.isCreatingMoreCards &&
                          !userDataProvider.isCreatingFirstCard
                      ? await nfcManager.stopSession().then((value) {
                          print("Stop Session with Cancel button");
                          Navigator.pop(context);
                        })
                      : await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          enableDrag: true,
                          showDragHandle: true,
                          useRootNavigator: true,
                          isDismissible: true,
                          builder: (BuildContext context) {
                            // var userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 40, bottom: 60),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Are You Sure?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Constants.primaryColorDarker,
                                      fontSize: 20,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.02,
                                    ),
                                  ),
                                  const SizedBox(height: 34),
                                  Text(
                                    'If you skip this step, you can add your NFC card later.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Constants.primaryColorDarker,
                                      fontSize: 19,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 26),
                                  TextButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(double.infinity, 46)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      print("NFC Skip");
                                      // List<int> jsonFileBinary = Provider.of<UserDataProvider>(context, listen: false).writeJsonToFileBinary();
                                      // int cardValue = Provider.of<UserDataProvider>(context, listen: false).userData.cardInformationList.length + 1;
                                      // String? imagePath = Provider.of<UserDataProvider>(context, listen: false).userData.profileImagePath ?? "";
                                      String? id =
                                          await TokenStorageService.getId();
                                      userDataProvider.addNewUserData();
                                      bool response = await userDataProvider
                                          .saveUserData(id, context);
                                      if (!response) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '$response',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Constants.primaryColor,
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 184, 183, 183),
                                            behavior: SnackBarBehavior.floating,
                                            width: 300,
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                        return;
                                      } else {
                                        print("Saved And Uploaded");
                                        await nfcManager
                                            .stopSession()
                                            .then((value) {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const LoginScreen();
                                              },
                                            ),
                                          );
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Skip',
                                      style: TextStyle(
                                        color: Constants.primaryColor,
                                        fontSize: 18,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.02,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(double.infinity, 46)),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.hovered)) {
                                          return Constants.primaryHoverColor;
                                        } else {
                                          return Constants.primaryColor;
                                        }
                                      }),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                      // showModalBottomSheet(
                                      //   context: context,
                                      //   isScrollControlled: true,
                                      //   builder: (BuildContext context) {
                                      //     return BottomSheetContent(
                                      //       onOptionSelected: (String option) {
                                      //         _handleOptionSelected(option);
                                      //       },
                                      //     );
                                      //   },
                                      // );
                                    },
                                    child: const Text(
                                      'Add NFC Card',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFFBFBFB),
                                        fontSize: 18,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.02,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                },
                child: const Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.02,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<T?> showInfoDialog<T>() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      useRootNavigator: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your NFC Card is already exists',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.primaryColorDarker,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.02,
                ),
              ),
              const SizedBox(height: 34),
              Text(
                'Please try another card',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.primaryColorDarker,
                  fontSize: 19,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 34),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 44)),
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
                  Navigator.pop(context);
                },
                child: const Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.02,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
