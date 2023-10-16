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
            Image(
              image: AssetImage(splashIcon),
              height: Get.width * .67,
            ),
            Text(
              appScreenName,
              style: TextStyle(
                fontSize: 27,
                fontFamily: "Roboto",
              ),
            ),
            SizedBox(
                width: Get.width * .8,
                child: Text(
                  appScreenText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 21,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.italic),
                ))
          ],
        ),
      ),
    );
  }
}
