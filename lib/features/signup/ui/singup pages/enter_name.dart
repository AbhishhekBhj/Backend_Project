import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/widgets/custom_header_widget.dart';

class EnterName extends StatefulWidget {
  EnterName(
      {super.key,
      required this.nameController,
      required this.onChanged,
      required this.isValidName});

  bool isValidName;
  TextEditingController nameController;
  // bool isValidName;
  VoidCallback onChanged;

  @override
  State<EnterName> createState() => _EnterNameState();
}

class _EnterNameState extends State<EnterName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomHeaderWidget(
            text: "Enter your full Name",
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: TextFormField(
                controller: widget.nameController,
                onChanged: (value) {

                  widget.onChanged();
                 
                },
                inputFormatters: [
                  // only accept letters from a to z and white space
                  FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s-]'),
                      allow: true)
                ],
                decoration: InputDecoration(
                  hintText: "Enter your full name",
                  errorText: widget.isValidName
                      ? null
                      : "Name must contain atleast 4 letters",
                )),
          )
        ],
      ),
    );
  }
}
