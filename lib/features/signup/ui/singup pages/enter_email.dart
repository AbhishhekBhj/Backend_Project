import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/widgets/custom_header_widget.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class EnterEmail extends StatefulWidget {
  EnterEmail({super.key, required this.onChanged, required this.isValidEmail, required this.emailController});

  TextEditingController emailController = TextEditingController();
  final VoidCallback onChanged;
  bool isValidEmail;
  @override
  State<EnterEmail> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           CustomHeaderWidget(
            text: "Enter your Email Address",

          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: TextFormField(
                controller: widget.emailController,
                onChanged: (value) {
                  widget.onChanged();
                },
                decoration: InputDecoration(
                  helperText: "We will send you a verification code",
                  hintText: "Enter your email address",
                  errorText: widget.isValidEmail
                      ? null
                      : "Please enter a valid email address",
                )),
          )
        ],
      ),
    );
  }
}
