import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/profile/ui/edit_profile.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class ViewProfile extends StatefulWidget {
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    "Profile Information",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ClipOval(
                  child: Container(
                    width: 250, // Adjust the width and height as needed
                    height: 250, // to control the circular shape
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: UserDataManager.userData["profile_picture"] != ""
                        ? Image.network(
                            'http://10.0.2.2:8000/media/${UserDataManager.userData['profile_picture']!}',
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.grey,
                            child: Icon(Icons.person,
                                size: 50, color: Colors.white),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildText("UserName", UserDataManager.userData['username']!),
              _buildText("Full Name", UserDataManager.userData['name']!),
              _buildText("Age", UserDataManager.userData['age'].toString()!),
              _buildText("Current Fitness Goal",
                  UserDataManager.userData['fitness_goal']!),
              _buildText("Email", UserDataManager.userData['email']!),
              _buildText("Pro Member Since",
                  UserDataManager.userData['is_pro_member']! ? "Yes" : "No"),
              _buildText(
                  "Fitness Level", UserDataManager.userData['fitness_level']!),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create styled text
  Widget _buildText(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title + " :",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
