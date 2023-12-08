import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/widgets/custom_header_widget.dart';

class EnterUsername extends StatefulWidget {
   EnterUsername({super.key, required this.onChanged, required this.isValidUsername, required this.usernameController});


TextEditingController usernameController = TextEditingController(); 
final VoidCallback onChanged;
bool isValidUsername;
  @override
  State<EnterUsername> createState() => _EnterUsernameState();
}

class _EnterUsernameState extends State<EnterUsername> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomHeaderWidget(
            text: "Enter your Username",
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: TextFormField(
                controller: widget.usernameController,
                onChanged: (value) {
                  widget.onChanged();
                },
                decoration: InputDecoration(
                  helperText: "This will be your unique username",
                  hintText: "Enter your username",
                  errorText: widget.isValidUsername
                      ? null
                      : "Please enter a valid username",
                )),
          )
        ],
      ),
    );
  }
}
