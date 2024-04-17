import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/signup_model.dart';
import '../../profile/bloc/bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileBloc profileBloc;
  late Map<String, dynamic> userData;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _fitnessLevelController = TextEditingController();
  final TextEditingController _fitnessGoalController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    fetchProfileData();
  }

  void fetchProfileData() {
    profileBloc.add(GetProfileInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInfoLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileInfoSuccessState) {
            userData = state.profileModel['data'];
            _updateTextControllers(userData);
            return _buildEditProfileForm(userData);
          } else if (state is ProfileInfoFailureState) {
            return Center(child: Text(state.errorMessage));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildEditProfileForm(Map<String, dynamic> userData) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
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
              imageUrl:
                  'http://10.0.2.2:8000/${userData['profile_picture'] ?? ''}',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
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
          ),
        ),
        _buildEditableFormField("Username", _nameController),
        _buildEditableFormField("Full Name", _ageController),
        _buildEditableFormField("Age", _weightController),
        _buildEditableFormField("Weight", _heightController),
        _buildFitnessLevelTextField(userData['fitness_level'] ?? ''),
        _buildFitnessGoalTextField(userData['fitness_goal'] ?? ''),
        _buildGenderTextField(userData['gender'] ?? ''),
        ElevatedButton(
          onPressed: () {
            profileBloc.add(EditProfileInformationClickedEvent(
              userModel: UserModel(
                name: _nameController.text,
                age: _ageController.text,
                weight: _weightController.text,
                height: _heightController.text,
                fitnessGoal: _fitnessGoalController.text,
                fitnessLevel: _fitnessLevelController.text,
                gender: _genderController.text,
              ),
            ));
          },
          child: Text("Save Changes"),
        ),
        BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileEditSuccessState) {
              profileBloc.add(GetProfileInfoEvent());

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully'),
                ),
              );
            }

            if (state is ProfileEditFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to update profile: "),
                ),
              );
              fetchProfileData();
            }
          },
          builder: (context, state) {
            if (state is ProfileInfoLoadingState) {
              return const CircularProgressIndicator();
            }
            if (state is ProfileEditLoadingState) {
              return const CircularProgressIndicator();
            }

            return Container();
          },
        ),
      ],
    );
  }

  Widget _buildEditableFormField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildFitnessLevelTextField(String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        controller: _fitnessLevelController,
        decoration: InputDecoration(
          labelText: 'Fitness Level',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your fitness level';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildFitnessGoalTextField(String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        controller: _fitnessGoalController,
        decoration: InputDecoration(
          labelText: 'Fitness Goal',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your fitness goal';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderTextField(String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        controller: _genderController,
        decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your gender';
          }
          return null;
        },
      ),
    );
  }

  void _updateTextControllers(Map<String, dynamic> userData) {
    _nameController.text = userData['name'] ?? '';
    _ageController.text = userData['age'].toString() ?? '';
    _weightController.text = userData['weight'].toString() ?? '';
    _heightController.text = userData['height'].toString() ?? '';
    _fitnessLevelController.text = userData['fitness_level'] ?? '';
    _fitnessGoalController.text = userData['fitness_goal'] ?? '';
    _genderController.text = userData['gender'] ?? '';
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
