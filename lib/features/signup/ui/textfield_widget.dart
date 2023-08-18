import 'package:flutter/material.dart';

class UserModelFormFields extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final String selectedActivityLevel; // Store the selected activity level
  final TextEditingController ageController;

  UserModelFormFields({
    required this.fullNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.usernameController,
    required this.passwordController,
    required this.selectedActivityLevel,
    required this.ageController,
  });

  // Define the available activity levels
  static const List<String> activityLevels = [
    'Low',
    'Moderate',
    'High',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ... other fields ...
        DropdownButtonFormField<String>(
          value: selectedActivityLevel,
          onChanged: (newValue) {
            // TODO: Update the selected activity level
          },
          items: activityLevels.map((level) {
            return DropdownMenuItem<String>(
              value: level,
              child: Text(level),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: 'Activity Level',
          ),
        ),
        
      ],
    );
  }
}
