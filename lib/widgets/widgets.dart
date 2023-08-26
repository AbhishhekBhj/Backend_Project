import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/texts/texts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appName),
      centerTitle: true,
      
      backgroundColor: MyColors.accentPurple,
    );
  }
}

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    super.key,
    required this.usernameController,
    required this.usernameLabel,
    required this.usernameHintText,
    required this.passwordController,
    required this.passwordLabel,
    required this.passwordHintText,
  });

  final TextEditingController usernameController;
  final String usernameLabel;
  final String usernameHintText;
  final TextEditingController passwordController;
  final String passwordLabel;
  final String passwordHintText;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}