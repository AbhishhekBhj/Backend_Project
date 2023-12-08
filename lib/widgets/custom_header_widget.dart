import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //CustomHeaderWidget(text: "Enter your number"),

        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: IconButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     icon: Icon(Icons.arrow_back_ios),
        //     color: Colors.grey,
        //   ),
        // ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ],
    );
  }
}
