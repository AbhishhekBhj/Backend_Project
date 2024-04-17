import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/profile/bloc/bloc/profile_bloc.dart';

class ViewProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ProfileBloc()..add(GetProfileInfoEvent()),
          child: ProfileInfoView(),
        ),
      ),
    );
  }
}

class ProfileInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInfoLoadingState) {
          // Show loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileInfoSuccessState) {
          // Show user profile information
          final profileData = state.profileModel['data'];
          return _buildProfileInfo(profileData);
        } else if (state is ProfileInfoFailureState) {
          // Show error message
          return Center(child: Text(state.errorMessage));
        }
        return Container();
      },
    );
  }

  // Function to build user profile information
  Widget _buildProfileInfo(Map<String, dynamic> profileData) {
    return Center(
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
          // Display profile information directly

          CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            imageUrl:
                "http://10.0.2.2:8000/${profileData['profile_picture']}" ?? '',
            width: 100,
            height: 100,
            placeholder: (context, url) => CircleAvatar(
              radius: 50,
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: 50,
              child: Icon(Icons.person),
            ),
          ),

          _buildText("UserName", profileData['username'] ?? ''),
          _buildText("Full Name", profileData['name'] ?? ''),
          _buildText("Age", profileData['age'].toString() ?? ''),
          _buildText("Current Fitness Goal", profileData['fitness_goal'] ?? ''),
          _buildText("Email", profileData['email'] ?? ''),
          _buildText("Pro Member ",
              profileData['is_pro_member'] ?? false ? "Yes" : "No"),
          _buildText("Fitness Level", profileData['fitness_level'] ?? ''),
          _buildText("Weight", profileData['weight'].toString() ?? ''),
          _buildText("Height", profileData['height'].toString() ?? ''),
          _buildText("Fitness Goal", profileData['fitness_goal'] ?? ''),
        ],
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
