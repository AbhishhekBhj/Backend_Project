import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterHeight extends StatelessWidget {
  const EnterHeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          const Text(
            'Enter Height',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: Get.width * 0.8,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Height',
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
