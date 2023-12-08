import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/widgets/custom_header_widget.dart';

class EnterPassword extends StatefulWidget {
  EnterPassword(
      {super.key,
      required this.onChanged,
      required this.isValidPassword,
      required this.passwordController});

  TextEditingController passwordController = TextEditingController();
  final VoidCallback onChanged;
  bool isValidPassword;

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

class _EnterPasswordState extends State<EnterPassword> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomHeaderWidget(
            text: "Enter your Password",
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: TextFormField(
                obscureText: _obscurePassword,
                controller: widget.passwordController,
                onChanged: (value) {
                  widget.onChanged();
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  helperText: "This will linked with your account",
                  hintText: "Enter your password",
                  errorText: widget.isValidPassword
                      ? null
                      : "Must have 8 characters, \n1 number, 1 uppercase letter , 1 special character",
                )),
          )
        ],
      ),
    );
  }
}
