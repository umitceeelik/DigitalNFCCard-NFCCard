import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Profile/SettingsScreen.dart';
import 'package:digital_nfc_card/Screen/Register/ProfileInformation.dart';
import 'package:digital_nfc_card/Services/TokenStorageService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class SettingsDigitalNFCCardProductsScreen extends StatefulWidget {
  const SettingsDigitalNFCCardProductsScreen({super.key});

  @override
  State<SettingsDigitalNFCCardProductsScreen> createState() =>
      _SettingsDigitalNFCCardProductsScreenState();
}

class _SettingsDigitalNFCCardProductsScreenState
    extends State<SettingsDigitalNFCCardProductsScreen> {
  List<CardBox> cardList = [];
  CardBox? currentOption;
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    setCards();
    double appBarHeightMultiplier = 0.07;
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()));
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: Constants.primaryColorDarker,
                    ),
                  ),
                  const Text(
                    'My Digital NFC Card Products',
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
              fontSize: Constants.responsiveFlex(screenWidth) > 0 ? 30 : 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              height: 0,
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
                                  if (cardList.isEmpty) ...[
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
                                            'No cards yet...',
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
                                            'To use the routing feature, you must have a digital NFC card.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Constants.primaryColorDarker,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ] else ...[
                                    Text(
                                      'My Cards',
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
                                    ...cardList.map((card) {
                                      currentOption ??= cardList[0];
                                      return RadioListTile<CardBox>(
                                        title: card,
                                        value: card,
                                        activeColor: Constants.primaryColorDarker,
                                        contentPadding: EdgeInsets.zero,
                                        groupValue: currentOption,
                                        onChanged: (value) {
                                          setState(() {
                                            if (kDebugMode) {
                                              print("Change Card");
                                            }
                                            userDataProvider.switchCardIndex(
                                                cardList.indexOf(value!));
                                          });
                                        },
                                      );
                                    }),
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
                          onPressed: null,
                          // () => _navigateToCreateNewProfilePage(context),
                          child: const Text(
                            'Order Digital NFC Card',
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
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 30.0, left: 30.0, right: 30.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(320, 45)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Constants.primaryHoverColor;
                                } else {
                                  return Constants.primaryBgColor;
                                }
                              }),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: Constants.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            onPressed: () async {
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
                              if (cardList.isEmpty) {
                                await showNFCDialog(true)
                                    .then((value) => setState(() {}));
                              } else {
                                await showNFCDialog(false);
                              }
                            },
                            child: Text(
                              ' Add An Existing Card',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.primaryColor,
                                fontSize: 18,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.02,
                              ),
                            )),
                      )
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
      ),
    );
  }

  // Set Links depends on the user's links
  void setCards() {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    cardList.clear();
    int index = 0;
    for (var cardInfo in userDataProvider.getCards()) {
      index++;
      addACard("Card $index", cardInfo.idNumber);
    }
    currentOption =
        cardList.isEmpty ? null : cardList[userDataProvider.cardIndex];
    index = 0;
  }

  void addACard(String name, String idNumber) {
    setState(() {
      cardList.add(CardBox(name, idNumber, removeCard));
    });
  }

  void removeCard(CardBox cardBox) {
    cardList.length > 1
        ? _showDeleteConfirmationDialog(cardBox, cardBox.detail, _onRemoveCard)
        : snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
            SnackBarType.error,
            'You must have at least one card in your account'));
  }

  Future<void> _onRemoveCard(CardBox cardBox) async {
    if (kDebugMode) {
      print("On remove card");
    }
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    if (cardList.length > 1) {
      userDataProvider.removeCard(cardBox.detail);
      String? userId = await TokenStorageService.getId();
      if (context.mounted) {
        await userDataProvider.saveUserData(userId, context);
        setState(() {
          cardList.remove(cardBox);
        });
      } else {
        if (kDebugMode) {
          print("Mounted context error!");
        }
      }
    }
  }

  void _showDeleteConfirmationDialog(
      CardBox cardBox, String id, Future<void> Function(CardBox) onConfirm) {
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
                  "Are you sure you want to delete $id Card?",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Color(0xFF191919),
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await onConfirm.call(cardBox);
                        if (dialogContext.mounted) {
                          Navigator.of(dialogContext).pop();
                        }
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

  Future<dynamic> saveCards() async {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    bool isChanged = false;

    // If 2 lists are empty, return
    if (cardList.isEmpty && userDataProvider.getCards().isEmpty) {
      // ignore: avoid_print
      print("No changed");
      return;
    }

    // If 2 lists' length are different, return
    if (cardList.length != userDataProvider.getCards().length) {
      isChanged = true;
    } else {
      // If 2 lists' length are same, check if there is any change
      for (var cardBox in cardList) {
        if (cardBox.name !=
                userDataProvider.getCards()[cardList.indexOf(cardBox)].name ||
            cardBox.detail !=
                userDataProvider
                    .getCards()[cardList.indexOf(cardBox)]
                    .idNumber) {
          isChanged = true;
          break;
        }
      }
    }

    // If there is no change, return
    if (!isChanged) {
      // ignore: avoid_print
      print("No changed");
      return;
    }
    // ignore: avoid_print
    print("Changed");
    userDataProvider.clearCardInformation();

    for (var cardBox in cardList) {
      userDataProvider.addCardInformation(cardBox.name, cardBox.detail);
    }
    String? id = await TokenStorageService.getId();
    await userDataProvider.saveUserData(id, context);
  }

  Future<void> _navigateToCreateNewProfilePage(BuildContext context) async {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    userDataProvider.isCreatingMoreCards = true;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileInformationScreen()),
    );
    // ignore: avoid_print
    print("REsulttt $result");
    if (result != null) {
      // AddACard(result['name'], result['description']);
    }
  }

  Future<T?> showNFCDialog<T>(bool isFirstCard) async {
    return isFirstCard
        ? showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              _ndefWrite1(context);
              return Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 40, bottom: 60),
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
                        height: 0.09,
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
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 34),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 44)),
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
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
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
                    ),
                  ],
                ),
              );
            },
          )
        : showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (BuildContext context) {
              // _ndefWrite1(context);
              return Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 40, bottom: 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Add a new NFC Card to your account',
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
                      'To add a new NFC card, you must first create a new profile.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Constants.primaryColorDarker,
                        fontSize: 19,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 34),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 44)),
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
                        // Navigator.pop(context);
                        _navigateToCreateNewProfilePage(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const ProfileInformationScreen(
                        //         isCreatingMoreCards: true,
                        //       )),
                        // );
                      },
                      child: const Text(
                        'Continue',
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
                    ),
                  ],
                ),
              );
            },
          );
  }

  void _ndefWrite1(BuildContext context) async {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    String cardIdentifierString = "";
    await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      //Read Nfc Card Serial Number
      List<int> nfcaIdentifier = isIOS ? tag.data["mifare"]["identifier"] : tag.data["nfca"]["identifier"];
      cardIdentifierString = listToString(nfcaIdentifier);

      print(cardIdentifierString);
      for (var element in userDataProvider.userDataList) {
        if (element.cardInformation.idNumber == cardIdentifierString) {
          snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
                                          SnackBarType.error, "Card already exists"));    
          //TODO: Show card is exists popup
          continue;
        }
      }

      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createUri(Uri.parse(
            "${Constants.baseProfileUrl}${await TokenStorageService.getId()}/$cardIdentifierString")),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession().then((value) async {
          print("ADDed");
          userDataProvider.addCardInformation(
              "Card ${cardList.length + 1}", cardIdentifierString);
          await userDataProvider.saveUserData(
              await TokenStorageService.getId(), context);
          setState(() {
            //cardList.add(CardBox("Card${cardList.length + 1}", cardIdentifierString, (CardBox) => {}));
            addACard("Card${cardList.length + 1}", cardIdentifierString);
          });
          Navigator.pop(context);
        });
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }

  String listToString(List<int> list) {
    // Joining the list elements into a single string
    String joinedString = list.map((e) => e.toString()).join();
    return joinedString;
  }
}

class CardBox extends StatelessWidget {
  final String name;
  final String detail;
  final Function(CardBox) onPressed;

  const CardBox(this.name, this.detail, this.onPressed, {super.key});
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

class AddNFCCardPage extends StatelessWidget {
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardIdController = TextEditingController();

  AddNFCCardPage({super.key});

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
                'My Digital NFC Card Products',
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
                                  'Card Title',
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
                                  controller: cardNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: "Add a description for the link",
                                    hintStyle: TextStyle(
                                      color: Constants.primaryColorDarker,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 10),
                                    border: OutlineInputBorder(
                                      borderSide:  BorderSide(
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
                                      return "Please enter your first name.";
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
                                  controller: cardIdController,
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
                                    contentPadding: const EdgeInsets.symmetric(
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
                                      return "Please enter your first name.";
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
                              // Save button
                              Navigator.pop(context, {
                                'name': cardNameController.text,
                                'description': cardIdController.text,
                              });
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
