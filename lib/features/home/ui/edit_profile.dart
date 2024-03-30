import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import cached_network_image package
import 'package:image_picker/image_picker.dart';
import 'package:mygymbuddy/features/profile/bloc/bloc/profile_bloc.dart';
import '../../../functions/shared_preference_functions.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Map<String, dynamic> userData;

  late ProfileBloc profileBloc;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    userData = UserDataManager.userData;
    log(userData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Get.height * 0.2,
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                imageUrl:
                    'http://10.0.2.2:8000/media/${UserDataManager.userData['profile_picture']!}',
                fit: BoxFit.contain,
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                  child:
                      const Icon(Icons.person, size: 50, color: Colors.white),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          InkWell(
              onTap: () {
                showImagePicker(context);
              },
              child: const Text(
                'Change Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '${userData['name']}' ?? 'Name',
                  ),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: '${userData['age']}' ?? 'Age',
                  ),
                ),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: '${userData['weight']}' ?? 'Weight',
                  ),
                ),
                TextField(
                  controller: _heightController,
                  decoration: const InputDecoration(
                    labelText: 'Height',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                getImage(ImageSource.camera, context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                getImage(ImageSource.gallery, context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        profileBloc.add(ProfileUploadProfilePictureEvent(image: imageFile));
      } else {
        showNoImageSelectedDialog(context);
      }
    } catch (e) {
      log('Error picking image: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to pick image. Please try again.'),
            actions: [
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

  void showNoImageSelectedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Image Selected'),
          content: const Text('Please select an image to continue.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
