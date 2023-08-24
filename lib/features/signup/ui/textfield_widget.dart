import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';

class UserModelFormFields extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController ageController;

  final String fullNameLabel;
  final String emailLabel;
  final String phoneNumberLabel;
  final String usernameLabel;
  final String passwordLabel;
  final String ageLabel;

  final String fullNameHintText;
  final String emailHintText;
  final String phoneNumberHintText;
  final String usernameHintText;
  final String passwordHintText;
  final String ageHintText;

  UserModelFormFields({
    required this.fullNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.usernameController,
    required this.passwordController,
    required this.ageController,
    required this.fullNameLabel,
    required this.emailLabel,
    required this.phoneNumberLabel,
    required this.usernameLabel,
    required this.passwordLabel,
    required this.ageLabel,
    required this.fullNameHintText,
    required this.emailHintText,
    required this.phoneNumberHintText,
    required this.usernameHintText,
    required this.passwordHintText,
    required this.ageHintText,
  });

  // Define the available activity levels

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.darkPurple, width: 4.0),
          borderRadius: BorderRadius.circular(4.0)),
      padding: EdgeInsets.all(20.0),
      margin:EdgeInsets.all(20.0) ,
      child: Column(
        children: [
          TextFormField(
            controller: fullNameController,
            decoration: InputDecoration(
                labelText: fullNameLabel, hintText: fullNameHintText),
          ),
          SizedBox(height: 2.0),
          TextFormField(
            controller: emailController,
            decoration:
                InputDecoration(labelText: emailLabel, hintText: emailHintText),
          ),
          SizedBox(height: 2.0),
          TextFormField(
            controller: phoneNumberController,
            decoration: InputDecoration(
                labelText: phoneNumberLabel, hintText: phoneNumberHintText),
          ),
          SizedBox(height: 2.0),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
                labelText: usernameLabel, hintText: usernameHintText),
          ),
          SizedBox(height: 2.0),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
                labelText: passwordLabel, hintText: passwordHintText),
          ),
          SizedBox(height: 2.0),
          TextFormField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(labelText: ageLabel, hintText: ageHintText),
          ),
        ],
      ),
    );
  }
}
