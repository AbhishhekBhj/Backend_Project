import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/profile/bloc/bloc/profile_bloc.dart';
import 'package:mygymbuddy/features/profile/ui/edit_profile.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class ViewProfile extends StatefulWidget {
  ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
 
  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = ProfileBloc();
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) {
          if (state is NavigateEditPageState) {}
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is ProfileViewFailureState) {
            return Center(
              child: Container(
                child: const Text(
                  "Error Loading the Page Try again",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          if (state is ProfileInitial) {
            return SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back)),
                        const Text(
                          "Profile Information",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(temporaryDP),
                    ),
                    const SizedBox(height: 20),
                    _buildText("UserName", "Abhishek123"),
                    _buildText("Full Name", "Abhishek Bhujel"),
                    _buildText("Age", "20"),
                    _buildText("Current Fitness Goal", "Cutting"),
                    _buildText("Email", "abc@example.com"),
                    _buildText("Member Since", "2023-09-01"),
                    _buildText("Pro Member Since", "2023-09-05"),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(() => EditProfile());
                        },
                        child: const Text("Edit Profile"))
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
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
