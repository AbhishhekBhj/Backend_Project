import 'package:flutter/material.dart';
import 'package:mygymbuddy/widgets/widgets.dart';


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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(15.0),
      child: LoginFormField(
          usernameController: usernameController,
          usernameLabel: usernameLabel,
          usernameHintText: usernameHintText,
          passwordController: passwordController,
          passwordLabel: passwordLabel,
          passwordHintText: passwordHintText),
    );
  }
}
