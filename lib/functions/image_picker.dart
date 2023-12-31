import 'dart:developer';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';

class ImagePickerClass extends StatelessWidget {
  const ImagePickerClass({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return Container();
  }

  static Future<void> showDialogueBox(BuildContext buildContext, int index,
      Function callback, bool isDarkMode) async {
    CroppedFile? croppedFile;

    showDialog(
      context: buildContext,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Choose Image"),
          content: SizedBox(
            height: Get.height * 0.3,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      XFile? image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        croppedFile = await cropImage(
                                context, File(image.path), isDarkMode)
                            .then((value) =>
                                value != null ? callback(value, index) : null);
                        log(croppedFile.toString());
                        callback(croppedFile, index);
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.camera_alt), Text("Camera")],
                    )),
                ElevatedButton(
                  onPressed: () async {
                    // log("Image picking from gallery");
                    XFile? image = await pickImageFromGallery(context);
                    // log("The image path is $image");
                    if (image != null) {
                      croppedFile = await cropImage(
                              context, File(image.path), isDarkMode)
                          .then((value) =>
                              value != null ? callback(value, index) : null);
                      log(croppedFile.toString());
                      callback(croppedFile, index);
                    }
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [Icon(Icons.image), Text("Gallery")],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<XFile?> pickImageFromCamera(BuildContext context) async {
    XFile? img;
    try {
      img = await ImagePicker().pickImage(source: ImageSource.camera);
    } catch (e) {
      if (e is PlatformException) {
        log(e.toString());

        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('An error occurred: ${e.message}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    return img;
  }

  static Future<XFile?> pickImageFromGallery(BuildContext context) async {
    XFile? img;
    try {
      img = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {
      if (e is PlatformException) {
        log(e.toString());

//ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('An error occurred: ${e.message}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    return img;
  }

  static Future<CroppedFile?> cropImage(
      BuildContext context, File imageFile, bool isDarkMode) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
            activeControlsWidgetColor: isDarkMode ? Colors.white : Colors.black,
            cropFrameColor: isDarkMode ? Colors.white : Colors.black,
            cropGridRowCount: 3,
            cropGridColor: isDarkMode ? Colors.white : Colors.black,
            statusBarColor: isDarkMode ? Colors.black : Colors.white,
            showCropGrid: true,
            toolbarTitle: 'Adjust Your Image',
            toolbarColor: isDarkMode ? Colors.black : Colors.white,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Adjust Image',
        ),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 520,
            height: 520,
          ),
          viewPort:
              const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        ),
      ],
    );
    log(croppedFile?.path.toString() ?? 'No path available');
    return croppedFile;
  }
}
