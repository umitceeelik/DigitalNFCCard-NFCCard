import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageService {
  
  static saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    print("SAVED token");
  }

  static saveId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    print("SAVED id");
  }

  static saveImagePath(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', imagePath);
    print("SAVED imagePath");
  }

  static saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    print("SAVED email");
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // print('Token : ${token}');
    return token;
  }

  static Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    // print('Token : ${token}');
    return id;
  }

  static Future<String?> getImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('imagePath');
    // print('Token : ${token}');
    return imagePath;
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    // print('Token : ${token}');
    return email;
  }

  static deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  static deleteId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("id");
  }

  static deleteImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("imagePath");
  }

  static deleteEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
  }

  static deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}