import 'dart:convert';
import 'package:digital_nfc_card/Datas/Card.dart';
import 'package:digital_nfc_card/Datas/EducationInformation.dart';
import 'package:digital_nfc_card/Datas/LinkInformation.dart';
import 'package:digital_nfc_card/Datas/UserData.dart';
import 'package:digital_nfc_card/Datas/WorkInformation.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:digital_nfc_card/Services/AuthService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  // to Create More Cards
  bool isCreatingMoreCards = false;
  bool _isCreatingFirstCard = false;
  bool get isCreatingFirstCard => _isCreatingFirstCard;
  set isCreatingFirstCard(bool value) {
    _isCreatingFirstCard = value;
    notifyListeners();
  }

  final UserData _newUserData = UserData();
  UserData get newUserData => _newUserData;
  set newUserData(UserData value) {
    _newUserData.firstName = value.firstName;
    _newUserData.lastName = value.lastName;
    _newUserData.title = value.title;
    _newUserData.aboutYou = value.aboutYou;
    _newUserData.profileImagePath = value.profileImagePath;
    _newUserData.socialMediaList = value.socialMediaList;
    _newUserData.phoneNumber = value.phoneNumber;
    _newUserData.contactEmail = value.contactEmail;
    _newUserData.website = value.website;
    _newUserData.workInformationList = value.workInformationList;
    _newUserData.educationInformationList = value.educationInformationList;
    _newUserData.linkInformationList = value.linkInformationList;
    _newUserData.cardInformation = value.cardInformation;
    _newUserData.themeName = value.themeName;
  }

  List<UserData> _userDataList = [];
  int _cardIndex = 0;
  int get cardIndex => _cardIndex;
  // UserData get userData => _userData;
  List<UserData> get userDataList => _userDataList;

  UserData get userData {
    if (_userDataList.isEmpty) {
      // _userDataList.add(UserData());
      return newUserData;
    }
    if (kDebugMode) {
      print(_cardIndex);
    }

    if (_cardIndex < _userDataList.length) {
      return _userDataList[_cardIndex];
    } else {
      switchCardIndex(0);
      return _userDataList[_cardIndex];
    }
  }

  void clearNewUserData() {
    newUserData = UserData();
  }

  void switchCardIndex(int newIndex) {
    if (newIndex >= 0 && newIndex < _userDataList.length) {
      _cardIndex = newIndex;
    }
  }

  bool switchCardIndexWithCardId(String? cardId) {
    if (cardId == null) {
      return false;
    }
    else {
      for (int i = 0; i < _userDataList.length; i++) {
        if (_userDataList[i].cardInformation.idNumber == cardId) {
          _cardIndex = i;
          return true;
        }
      }
      return false;
    }
  }
  
  void addUserData(UserData userData) {
    _userDataList.add(userData);
    notifyListeners();
  }

  void addNewUserData() {
    UserData userData = UserData();
    userData.firstName = newUserData.firstName;
    userData.lastName = newUserData.lastName;
    userData.title = newUserData.title;
    userData.aboutYou = newUserData.aboutYou;
    userData.profileImagePath = newUserData.profileImagePath;
    userData.socialMediaList = newUserData.socialMediaList;
    userData.phoneNumber = newUserData.phoneNumber;
    userData.contactEmail = newUserData.contactEmail;
    userData.website = newUserData.website;
    userData.workInformationList = newUserData.workInformationList;
    userData.educationInformationList = newUserData.educationInformationList;
    userData.linkInformationList = newUserData.linkInformationList;
    userData.cardInformation = newUserData.cardInformation;
    userData.themeName = newUserData.themeName;
    _userDataList.add(userData);
    notifyListeners();
  }

  void clearUserDataList() {
    _userDataList.clear();
  }

  void setEmail(String email) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData).email =
        email;
    notifyListeners();
  }

  void setPassword(String password) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData).password =
        password;
    notifyListeners();
  }

  void setNames(
      String firstName, String lastName, String title, String aboutYou) {
    if (!isCreatingMoreCards) {
      print("old names");
      _userDataList[_cardIndex].firstName = firstName;
      _userDataList[_cardIndex].lastName = lastName;
      _userDataList[_cardIndex].title = title;
      _userDataList[_cardIndex].aboutYou = aboutYou;
    } else {
      print("new names");
      _newUserData.firstName = firstName;
      _newUserData.lastName = lastName;
      _newUserData.title = title;
      _newUserData.aboutYou = aboutYou;
    }
    notifyListeners();
  }

  void setProfileImagePath(String imagePath) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .profileImagePath = imagePath;
    notifyListeners();
  }

  void setThemeType(String themeName) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .themeName = themeName;
    notifyListeners();
  }

  void addSocialMedia(String socialMediaName, String username) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .socialMediaList[socialMediaName] = username;
    notifyListeners();
  }

  void removeSocialMedia(String socialMediaName) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .socialMediaList
        .remove(socialMediaName);
    notifyListeners();
  }

  void clearSocialMedia() {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .socialMediaList
        .clear();
  }

  // void setToken(String token) {
  //   _userData.token = token;
  //   notifyListeners();
  // }

  void setContactInformation(
      String phoneNumber, String contactEmail, String website) {
    if (!isCreatingMoreCards) {
      _userDataList[_cardIndex].phoneNumber = phoneNumber;
      _userDataList[_cardIndex].contactEmail = contactEmail;
      _userDataList[_cardIndex].website = website;
    } else {
      _newUserData.phoneNumber = phoneNumber;
      _newUserData.contactEmail = contactEmail;
      _newUserData.website = website;
    }
    notifyListeners();
  }

  void addWorkInformation(
      String companyName, String jobTitle, String taxID, String iban) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .workInformationList
        .add(WorkInformation(
            companyName: companyName,
            jobTitle: jobTitle,
            taxId: taxID,
            iban: iban));
    notifyListeners();
    // print("TEST2 ${_userData.workInformationList.length}");
  }

  void clearWorkInformation() {
    !isCreatingMoreCards
        ? _userDataList[_cardIndex].workInformationList.clear()
        : _newUserData.workInformationList.clear();
    notifyListeners();
  }

  void addEducationInformation(String schoolName, String degree,
      String fieldOfStudy, String startingDate, String endingDate) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .educationInformationList
        .add(EducationInformation(
            schoolName: schoolName,
            degree: degree,
            fieldOfStudy: fieldOfStudy,
            startingDate: startingDate,
            endingDate: endingDate));
    notifyListeners();
    // print("TEST2 ${_userData.workInformationList.length}");
  }

  void clearEducationInformation() {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .educationInformationList
        .clear();
    notifyListeners();
  }

  void addLinkInformation(String name, String url) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .linkInformationList
        .add(LinkInformation(name: name, url: url));
    // print("TEST2 ${_userData.workInformationList.length}");
  }

  void clearLinkInformation() {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .linkInformationList
        .clear();
    notifyListeners();
  }

  void addCardInformation(String name, String idNumber) {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .cardInformation
        .name = name;
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .cardInformation
        .idNumber = idNumber;
    notifyListeners();
    // print("TEST2 ${_userData.workInformationList.length}");
  }

  void clearCardInformation() {
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .cardInformation
        .name = "";
    (!isCreatingMoreCards ? _userDataList[_cardIndex] : _newUserData)
        .cardInformation
        .idNumber = "";
    notifyListeners();
  }

  List<CardInformation> getCards() {
    List<CardInformation> cardList = [];
    for (int i = 0; i < _userDataList.length; i++) {
      if (_userDataList[i].cardInformation.name != "" &&
          _userDataList[i].cardInformation.idNumber != "") {
        cardList.add(_userDataList[i].cardInformation);
      }
    }
    return cardList;
  }

  void removeCard(String cardIdNumber) {
    for (int i = 0; i < _userDataList.length; i++) {
      if (_userDataList[i].cardInformation.idNumber == cardIdNumber) {
        if (kDebugMode) {
          print("Card index found");
        }
        if (_cardIndex == i) {
          _cardIndex = 0;
        }
        notifyListeners();
        _userDataList.removeAt(i);
        notifyListeners();
        return;
      }
    }
  }

  // Update the setDataFromJson method
  void setDataFromJson(Map<String, dynamic> jsonData) {
    print("object2");
    _userDataList =
        (jsonData['userDataList'] as List<dynamic>?)?.map((userDataJson) {
              UserData userData = UserData();
              userData.fromJson(userDataJson);
              return userData;
            }).toList() ??
            [];
    _cardIndex = jsonData['cardIndex'] ?? 0;
    Constants.setTheme(_userDataList[_cardIndex].themeName);
    // if (_userDataList.isEmpty) {
    //   _userDataList.add(UserData());
    // }
    notifyListeners();
  }

  // Update the writeJsonToFileBinary method
  List<int> writeJsonToFileBinary() {
    final jsonContent = {
      'userDataList':
          _userDataList.map((userData) => userData.toJson()).toList(),
      'cardIndex': _cardIndex
    };
    print("JSONN $jsonContent");
    return utf8.encode(jsonEncode(jsonContent));
  }

  // Future<dynamic> saveUserData(String? id) async{
  //   List<int> jsonFileBinary = writeJsonToFileBinary();
  //   int cardValue = 1;
  //   String? imagePath = userData.profileImagePath;
  //   await AuthService.uploadFiles("users/${id}/Card${cardValue}/data", imagePath, jsonFileBinary);
  // }

  // Update the saveUserData method
  Future<bool> saveUserData(String? id, BuildContext context) async {
    Map<String, String> imagePathList = {};
    for (int i = 0; i < _userDataList.length; i++) {
      UserData currentUserData = _userDataList[i];
      String? imagePath = currentUserData.profileImagePath;
      imagePathList[currentUserData.cardInformation.idNumber == ""
          ? "cardlessProfileImage"
          : currentUserData.cardInformation.idNumber] = imagePath;
        }
    List<int> jsonFileBinary = writeJsonToFileBinary();
    String response = await AuthService.uploadFiles(
        context, "user/$id/Card/", imagePathList, jsonFileBinary);
    if (response == "Success") {
      return true;
    } else {
      return false;
    }
  }

/*
  void setContactInfo(String key, dynamic value) {
    _userData.additionalInfo[key] = value;
    notifyListeners();
  }

  void setAdditionalInfo(String key, dynamic value) {
    _userData.additionalInfo[key] = value;
    notifyListeners();
  }

  void clearUserData() {
    _userData.clear();
    notifyListeners();
  }
*/
}
