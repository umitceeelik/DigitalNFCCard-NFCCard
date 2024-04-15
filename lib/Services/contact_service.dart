import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {
  // Contact Service

  static String createVcf(
      String fName, String lName, String phoneNumber, String email) {
    return '''BEGIN:VCARD
VERSION:3.0
N:$lName;$fName
ORG:
TEL:$phoneNumber
EMAIL:$email
END:VCARD''';
  }

  static void addContactMobile(
      String fName, String lName, String phoneNumber, String email) async {
    if (await FlutterContacts.requestPermission()) {
      final directory = await getTemporaryDirectory();
      final path = directory.path;
      var pathAsText = "$path/$fName.txt";

      final newContact = Contact()
        ..name.first = fName
        ..name.last = lName
        ..phones = [Phone(phoneNumber)];

      final contact = await FlutterContacts.openExternalInsert(newContact);
    }
  }

  static void shareContactMobile(String vcard) async {
    String contactPath;

    final directory = await getTemporaryDirectory();
    final path = directory.path;
    var pathAsText = "$path/card.txt";
    var contactAsFile = File(await getFilePath("card".toString()));
    contactAsFile.writeAsString(vcard);

    var vcf =
        contactAsFile.renameSync(contactAsFile.path.replaceAll(".txt", ".vcf"));

    contactPath = vcf.path;

    final result = await Share.shareXFiles(
        [XFile('${directory.path}/card.vcf')],
        text: 'Contact to share :)');

    if (result.status == ShareResultStatus.success) {
      print('Contact shared successfully');
    } else {
      print("Error occured when sharing contact, please try again later.");
    }
  }

  static Future<String> getFilePath(String fileName) async {
    Directory appDocumentsDirectory = await getTemporaryDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/$fileName.txt';

    return filePath;
  }
}
