import 'dart:io';

import 'package:digital_nfc_card/Datas/Card.dart';
import 'package:digital_nfc_card/Datas/EducationInformation.dart';
import 'package:digital_nfc_card/Datas/LinkInformation.dart';
import 'package:digital_nfc_card/Datas/WorkInformation.dart';

class UserData {
  String email = "";
  String password = "";

  // Profile Information
  String firstName = "";
  String lastName = "";
  String title = "";
  String aboutYou = "";

  // Social Medias
  Map<String, String> socialMediaList = {};

  // Contact Information
  String phoneNumber = "";
  String contactEmail = "";
  String website = "";

  // Work Information
  List<WorkInformation> workInformationList = [];

  // Education Information
  List<EducationInformation> educationInformationList = [];

  // Links
  List<LinkInformation> linkInformationList = [];

  // Cards
  CardInformation cardInformation = CardInformation(name: "", idNumber: "");

  // Profile Image
  String profileImagePath = "";

  // Profile theme
  String themeName = "";

  File? image;
  // // Default constructor
  // UserData({
  //   this.email,
  //   this.password,
  //   this.firstName,
  //   this.lastName,
  //   this.aboutYou,
  //   this.phoneNumber,
  //   this.contactEmail,
  //   this.website,
  //   this.workInformationList = const [],
  //   this.educationInformationList = const [],
  //   this.socialMediaList = const {},
  //   this.linkList = const {},
  //   this.cardList = const {},
  //   this.profileImagePath,
  // });

/*
  UserData({
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.aboutYou,
    this.phoneNumber,
    this.contactEmail,
    this.website,
    this.workInformationList = const [],
    this.educationInformationList = const [],
    this.socialMediaList = const {},
    this.linkList = const {},
    this.cardList = const {},
    this.profileImagePath,
  });

  // Factory method to create UserData from JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      aboutYou: json['aboutYou'],
      socialMediaList: Map<String, String>.from(json['socialMediaList'] ?? {}),
      phoneNumber: json['phoneNumber'],
      contactEmail: json['contactEmail'],
      website: json['website'],
      workInformationList: (json['workInformationList'] as List<dynamic>?)
          ?.map((workInfoJson) => WorkInformation.fromJson(workInfoJson))
          .toList() ??
          [],
      educationInformationList: (json['educationInformationList'] as List<dynamic>?)
          ?.map((eduInfoJson) => EducationInformation.fromJson(eduInfoJson))
          .toList() ??
          [],
      linkList: Map<String, String>.from(json['linkList'] ?? {}),
      cardList: Map<String, String>.from(json['cardList'] ?? {}),
      profileImagePath: json['profileImagePath'],
    );
  }

  */

  void fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    title = json['title'];
    aboutYou = json['aboutYou'];
    socialMediaList = Map<String, String>.from(json['socialMediaList'] ?? {});
    phoneNumber = json['phoneNumber'];
    contactEmail = json['contactEmail'];
    website = json['website'];
    workInformationList = (json['workInformationList'] as List<dynamic>?)
        ?.map((workInfoJson) => WorkInformation.fromJson(workInfoJson))
        .toList() ??
        [];
    educationInformationList = (json['educationInformationList'] as List<dynamic>?)
        ?.map((eduInfoJson) => EducationInformation.fromJson(eduInfoJson))
        .toList() ??
        [];
    linkInformationList = (json['linkInformationList'] as List<dynamic>?)
        ?.map((linkInfoJson) => LinkInformation.fromJson(linkInfoJson))
        .toList() ??
        [];
    // cardInformationList = (json['cardInformationList'] as List<dynamic>?)
    //     ?.map((cardInfoJson) => CardInformation.fromJson(cardInfoJson))
    //     .toList() ??
    //     [];
    cardInformation = CardInformation.fromJson(json['cardInformation']);
    profileImagePath = json['profileImagePath'];
    themeName = json['themeName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'title': title,
      'aboutYou': aboutYou,
      'socialMediaList': socialMediaList,
      'phoneNumber': phoneNumber,
      'contactEmail': contactEmail,
      'website': website,
      'workInformationList': workInformationList.map((workInfo) => workInfo.toJson()).toList(),
      'educationInformationList': educationInformationList.map((eduInfo) => eduInfo.toJson()).toList(),
      'linkInformationList': linkInformationList.map((linkInfo) => linkInfo.toJson()).toList(),
      'cardInformation': cardInformation.toJson(),
      'profileImagePath': profileImagePath,
      'themeName': themeName,
    };
  }
}