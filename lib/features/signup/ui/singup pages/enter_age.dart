import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:mygymbuddy/widgets/custom_header_widget.dart";

class EnterAge extends StatefulWidget {
  EnterAge(
      {super.key,
      required this.onChanged,
      required this.isValidAge,
      required this.ageController});

  TextEditingController ageController;
  final VoidCallback onChanged;
  bool isValidAge;

  @override
  State<EnterAge> createState() => _EnterAgeState();
}

class _EnterAgeState extends State<EnterAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomHeaderWidget(
            text: "Enter your Age",
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: TextFormField(
                keyboardType: TextInputType.number,
                controller: widget.ageController,
                onChanged: (value) {
                  widget.onChanged();
                },
                decoration: InputDecoration(
                  helperText: "This will linked with your account",
                  hintText: "Enter your age",
                  errorText: widget.isValidAge
                      ? null
                      : "Must be greater than 13 to use this application",
                )),
          )
        ],
      ),
    );
  }
}
