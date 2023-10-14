import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image(image: AssetImage(splashIcon)),
            Text(
              appScreenName,
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
                width: Get.width * .85,
                child: Text(
                  appScreenText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ))
          ],
        ),
      ),
    );
  }
}
