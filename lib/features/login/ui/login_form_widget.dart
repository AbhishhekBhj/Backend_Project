import 'package:flutter/material.dart';

import '../../../colours/colours.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final String usernameLabel;
  final String passwordLabel;
  final String usernameHintText;
  final String passwordHintText;

  LoginForm({
    required this.usernameController,
    required this.passwordController,
    required this.usernameLabel,
    required this.passwordLabel,
    required this.usernameHintText,
    required this.passwordHintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.accentBlue, width: 4.0),
          borderRadius: BorderRadius.circular(4.0)),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
