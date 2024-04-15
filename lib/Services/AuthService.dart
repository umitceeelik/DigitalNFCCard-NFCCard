// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:digital_nfc_card/Services/LoadingIndicator.dart';
import 'package:digital_nfc_card/Services/TokenStorageService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  static String baseUrl =
      'o3n3xclrqvl5xye44kcvjsv6kq0bxhtg.lambda-url.eu-west-1.on.aws';

  static Future<dynamic> register(BuildContext context, String email, String password) async {
    LoadingIndicator.showLoadingIndicator(context);
    try {
      var url = Uri.https(baseUrl, 'api/Auth/register');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': password,
          }));

      print("Register");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print("Success");
        String json = response.body;
        String id = jsonDecode(json)['id'];
        await TokenStorageService.saveId(id);
        return "Success";
      } else {
        String error = response.body;
        if (error == "The id has registered before.") {
          error = "Email already exists";
        }
        print('Error : $error');
        // Return the response body or any other relevant data
        return error;
      }
      // return response.body;
    } catch (e) {
      print(e.toString());
      return "Register failed";
    }
    finally {
      LoadingIndicator.hideLoadingIndicator();
    }
  }

  static Future<dynamic> login(BuildContext context, String email, String password) async {
    LoadingIndicator.showLoadingIndicator(context);
    try {
      var url = Uri.https(baseUrl, 'api/Auth/Login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}));
      print("Login");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        String json = response.body;

        String token = jsonDecode(json)['token'];
        String id = jsonDecode(json)['id'];

        // String token = response.body;
        // String id = "1";

        // Save the token using your storage solution (TokenStorage in this case)
        await TokenStorageService.saveToken(token);
        await TokenStorageService.saveId(id);
        print('Token : ${await TokenStorageService.getToken()}');
        print('Id : ${await TokenStorageService.getId()}');
        // Return the response body or any other relevant data
        return "Success";
      } else {
        String error = response.body;
        print('Error : $error');
        // Return the response body or any other relevant data
        return error;
      }
    } catch (e) {
      print(e.toString());
    }
    finally {
      LoadingIndicator.hideLoadingIndicator();
    }
  }

  static Future<dynamic> logOut() async {
    try {
      print("LogOut");
      await TokenStorageService.deleteAll();
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<String> uploadFiles(BuildContext context, String path,
      Map<String, String>? imagePathList, List<int> jsonFileBinary) async {
    LoadingIndicator.showLoadingIndicator(context);
    try {
      String bucketName = "atlas-prod-id-origin";
      var url = Uri.https(baseUrl, 'api/UploadFileAws');
      var requestMultipart = http.MultipartRequest('POST', url);

      if (imagePathList != null && imagePathList.isNotEmpty) {
        for (var id in imagePathList.keys) {
          if (imagePathList[id]!.isNotEmpty) {
            print("Image Path : ${imagePathList[id]!}");
            requestMultipart.files.add(await http.MultipartFile.fromPath(
                'files', imagePathList[id]!,
                filename: "$id.png"));
          }
        }
      }
      requestMultipart.files.add(http.MultipartFile.fromBytes(
          'files', jsonFileBinary,
          filename: "data.json"));

      // Add other fields to the request
      requestMultipart.fields['bucketName'] = bucketName;
      requestMultipart.fields['path'] = path;

      var response = await requestMultipart.send();

      print("Upload");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.reasonPhrase}');

      if (response.statusCode == 200){
        return "Success";
      }
      else {
        String? error = response.reasonPhrase;
        print('Error : $error');
        return error ?? "Error";
      }
    } catch (e) {
      print('Error uploading file: $e');
      return "Error";
    }
    finally {
      LoadingIndicator.hideLoadingIndicator();
    }
  }

  static Future<dynamic> sendResetPasswordCode(
      String email, BuildContext context) async {
    try {
      // LoadingIndicator.showLoadingIndicator(context);
      var url = Uri.https(baseUrl, 'api/Auth/SendResetPasswordCode');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email}));
      print("sendResetPasswordCode");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        String json = response.body;
        snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
                                          SnackBarType.success,
                                          'Reset Password Code has been sent to your email address.'));
      } else {
        String error = response.body;
        print('Error : $error');
        // Return the response body or any other relevant data
        snackbarKey.currentState?.showSnackBar(Constants.SnackBarWidget(
                                          SnackBarType.error,
                                          'Reset Password Code could not be sent. Please try again.'));
        return error;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      // LoadingIndicator.hideLoadingIndicator();
    }
  }

  static Future<bool> changePasswordWithResetCode(String email,
      String resetCode, String newPassword, BuildContext context) async {
    try {
      LoadingIndicator.showLoadingIndicator(context);
      var url = Uri.https(baseUrl, 'api/Auth/ChangePasswordWithResetCode');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'resetCode': resetCode,
            'newPassword': newPassword
          }));
      print("ChangePasswordWithResetCode");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        String json = response.body;
        print(json);
        return true;
      } else {
        String error = response.body;
        print('Error : $error');
        // Return the response body or any other relevant data
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      LoadingIndicator.hideLoadingIndicator();
    }
  }

  static Future<String> changePasswordWithPassword(
      String currentPassword, String newPassword, BuildContext context) async {
    try {
      LoadingIndicator.showLoadingIndicator(context);
      var url = Uri.https(baseUrl, 'api/Auth/ChangePassword');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'id': await TokenStorageService.getId(),
            'currentPassword': currentPassword,
            'newPassword': newPassword
          }));
      print("changePasswordWithPassword");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        String json = response.body;
        print(json);
        return "Success";
        // Navigator.of(context).pop();
      } else {
        String error = response.body;
        print('Error : $error');
        // Return the response body or any other relevant data
        return error;
      }
    } catch (e) {
      print(e.toString());
      return "Error";
    } finally {
      LoadingIndicator.hideLoadingIndicator();
    }
  }

  static Future<bool> fetchDataFromAws(
      BuildContext context, String? id) async {
    LoadingIndicator.showLoadingIndicator(context);

    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    bool isIdNull = id == null;
    id ??= await TokenStorageService.getId();
    if (id == null) {
      print("Id can not be null");
      return false;
    }
    var url = Uri.https("id.atlas.space", '/user/$id/Card/data.json');
    final response = await http.get(url, headers: {'Accept-Charset': 'utf-8'});
    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        print('Decoded Data: $jsonData');
        // Use the UserDataProvider to update the data from JSON
        userDataProvider.setDataFromJson(jsonData);

        await getProfileImage(
            userDataProvider.userData.cardInformation.idNumber, context);

        return true;        
      } catch (e) {
        print("Error ${e.toString()}");

        return false;
      } finally {
        LoadingIndicator.hideLoadingIndicator();
      }
    } else if (response.statusCode == 404) {
      LoadingIndicator.hideLoadingIndicator();
      return false;
    } else {
      print('Failed to fetch data from AWS. Status code: ${response.statusCode}');
      LoadingIndicator.hideLoadingIndicator();
      return false;
    }
  }

  static Future<dynamic> getProfileImage(String? cardId, BuildContext context) async {
    var userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    if (userDataProvider.userData.profileImagePath.isNotEmpty) {
      List<int> imageBytes = await AuthService.fetchImageFromAws(cardId);
      // Get the temporary directory using path_provider
      Directory tempDir = await getTemporaryDirectory();
      // Create a File in the temporary directory
      File image = File('${tempDir.path}/${(cardId == "" || cardId == null) ? "cardlessProfileImage" : cardId}.png');
      // Write the bytes to the file
      await image.writeAsBytes(imageBytes);
      userDataProvider.setProfileImagePath(image.path);
      userDataProvider.userData.image = image;
    }
  }

  static Future<dynamic> fetchImageFromAws(String? cardId) async {
    try {
      String? id = await TokenStorageService.getId();
      if (id == null) {
        print("Id can not be null");
        return;
      }
      var imagePath = (cardId == "" || cardId == null)
          ? "/user/$id/Card/cardlessProfileImage.png"
          : '/user/$id/Card/$cardId.png';
      var url = Uri.https("id.atlas.space", imagePath);
      final imageResponse = await http.get(url);
      print(imageResponse.statusCode);
      if (imageResponse.statusCode == 200) {
        final List<int> imageBytes = imageResponse.bodyBytes;
        return imageBytes;
      } else if (imageResponse.statusCode == 404) {
        return null;
      } else {
        print(
            'Failed to fetch data from AWS. Status code: ${imageResponse.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
