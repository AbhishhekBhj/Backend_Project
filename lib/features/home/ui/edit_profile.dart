import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../functions/shared_preference_functions.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Map<String, dynamic> userData;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String selectedGender = "Gender";
  String selectedFitnessGoal = "";
  String selectedFitnessLevel = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = UserDataManager.userData;
    log(userData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: ListView(
        children: [
          Container(
            width: Get.height * 0.2,
            height: Get.height * 0.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: UserDataManager.userData["profile_picture"] != ""
                ? Image.network(
                    'http://10.0.2.2:8000/media/${UserDataManager.userData['profile_picture']!}',
                    fit: BoxFit.contain,
                  )
                : Container(
                    color: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight',
                  ),
                ),
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: 'Height',
                  ),
                ),
                
                DropdownButton<String>(
                  value: selectedFitnessLevel,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFitnessLevel = newValue!;
                    });
                  },
                  items: [
                    "Select FitnessLevel",
                    "Begineer",
                    "Intermediate",
                    "Advanced"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // DropdownButton<String>(
                //   value: selectedGender,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedGender = newValue!;
                //     });
                //   },
                //   items: ["Select Gender", "Male", "Female"]
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
                DropdownButton<String>(
                  value: selectedFitnessGoal,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFitnessGoal = newValue!;
                    });
                  },
                  items: [
                    "Select FitnessGoal",
                    "Bulking",
                    "Cutting",
                    "Maintainance"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
