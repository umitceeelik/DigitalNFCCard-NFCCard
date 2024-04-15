// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/Constants.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:nfc_read_write/Profile/ProfileScreen.dart';

class EditProfilePhotoScreen extends StatefulWidget {
  final String? imagePath;
  const EditProfilePhotoScreen({super.key, this.imagePath});

  @override
  State<EditProfilePhotoScreen> createState() => _EditProfilePhotoScreenState();
}

class _EditProfilePhotoScreenState extends State<EditProfilePhotoScreen> {

  int addedEducationCount = 0;

  File? _image;

  Future _pickImage(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);

      if(image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      cropStyle: CropStyle.circle,
      );
    if (croppedImage == null) return null;
    Provider.of<UserDataProvider>(context, listen: false).setProfileImagePath(croppedImage.path);
    // TokenStorageService.saveImagePath(croppedImage.path);
    return File(croppedImage.path);
  }

  void _showSelectImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 26, right: 26, top: 40, bottom: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Edit Profile Photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Constants.primaryColorDarker,
                    fontSize: 22,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    height: 0.09,
                    letterSpacing: 0.02,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                  onPressed: () async{
                    if(_image == null) return;
                    File? oldImage = _image;
                    File? img = await _cropImage(imageFile: _image!);
                    setState(() {
                      if(img != null) {
                        _image = img;
                      } else {
                        _image = oldImage;
                      }
                    });
                  },
                  child: Text(
                    "View Profile Photo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.primaryColorDarker,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                      letterSpacing: 0.02,
                    ),
                  )),
              const SizedBox(height: 34),
              TextButton(
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                  child: Text(
                    "Take a Photo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.primaryColorDarker,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                      letterSpacing: 0.02,
                    ),
                  )),
              const SizedBox(height: 34),
              TextButton(
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: Text(
                    "Upload From Photos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.primaryColorDarker,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                      letterSpacing: 0.02,
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _image = widget.imagePath != null ? File(widget.imagePath!) : null;
    Future.delayed(Duration.zero, () {
      _showSelectImageOptions(context);
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
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(
                top: 10,
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
                    Navigator.pop(context, {
                                'imagePath': _image == null ? "" : _image!.path,
                              });
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: Constants.primaryColorDarker,
                  ),
                ),
                const Text(
                  "Profile Photo",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 24),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 40),
                child: Column(
                  children: [
                    SizedBox(
                      width: screenWidth > screenHeight ? screenHeight/1.5 : screenWidth/1.5,
                      height: screenWidth > screenHeight ? screenHeight/1.5 : screenWidth/1.5,
                      child: Container(
                        // width: screenWidth/3,
                        // height: screenWidth/2,
                        decoration: const ShapeDecoration(
                          color: Color(0x7FB5B5B5),
                          shape: OvalBorder(
                            side: BorderSide(
                              width: 3,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFFFBFBFB),
                            ),
                          ),
                        ),
                        child: Center(
                          child: _image == null
                              ? Icon(
                                  Icons.add_photo_alternate,
                                  size: 24,
                                  color: Constants.primaryColorDarker,
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(_image!),
                                  radius: screenWidth > screenHeight
                                      ? screenHeight / 1.5
                                      : screenWidth / 1.5,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {_showSelectImageOptions(context);},
                          icon:  Icon(
                            Icons.edit_rounded,
                            size: 24,
                            color: Constants.primaryColorDarker,
                            ),
                        ),
                        const SizedBox(width: 18),
                        IconButton(
                          onPressed: () {_pickImage(ImageSource.camera);},
                          icon:  Icon(
                            Icons.photo_camera_rounded,
                            size: 24,
                            color: Constants.primaryColorDarker,
                            ),
                        ),
                        const SizedBox(width: 18),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if(_image != null) _image = null; 
                            });
                          },
                          icon:  Icon(
                            Icons.delete_rounded,
                            size: 24,
                            color: Constants.primaryColorDarker,
                            ),
                        ),
                      ],
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
}