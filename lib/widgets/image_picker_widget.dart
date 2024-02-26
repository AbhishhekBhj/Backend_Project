import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatefulWidget {
  final bool isProMember;
  final Function(File) onImageCropped; // Callback function

  PickImageWidget({
    Key? key,
    required this.isProMember,
    required this.onImageCropped,
  }) : super(key: key);

  @override
  _PickImageWidgetState createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  width: double.infinity,
                ),
                Positioned(
                  right: Get.width * 0.2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    XFile? image = await _pickImage(context);
    if (image != null) {
      File croppedImage = await _cropImage(context, File(image.path));
      widget.onImageCropped(croppedImage); // Callback to parent widget
    }
  }

  Future<XFile?> _pickImage(BuildContext context) async {
    XFile? img;
    try {
      img = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {
      if (e is PlatformException) {
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

  Future<File> _cropImage(BuildContext context, File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: Platform.isAndroid
          ? [
              AndroidUiSettings(
                activeControlsWidgetColor: Colors.blue,
                cropFrameColor: Colors.blue,
                cropGridRowCount: 3,
                cropGridColor: Colors.blue,
                statusBarColor: Colors.blue,
                showCropGrid: true,
                toolbarTitle: 'Adjust Your Image',
                toolbarColor: Colors.blue,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: true,
              )
            ]
          : [
              IOSUiSettings(
                title: 'Adjust Image',
              )
            ],
    );
    return croppedFile != null ? File(croppedFile.path!) : imageFile;
  }
}
