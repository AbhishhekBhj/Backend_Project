import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/graph/ui/graph_ui.dart';
import 'package:mygymbuddy/features/home/ui/common_ui.dart';
import 'package:mygymbuddy/features/signup/ui/welcome_screen.dart/welcome_screen.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  @override
  void initState() {
    UserDataManager.init();
    checkUserNameAndNavigate();
    super.initState();
  }

  void checkUserNameAndNavigate() async {
    String? username = UserDataManager.userData['username'];

    // Check if username is null or empty
    if (username == null || username.isEmpty) {
      // Username is null or empty, navigate to WelcomeScreen after the build phase completes
      await Future.delayed(Duration(
          seconds: 3)); // Ensure this is executed after the build phase
      Get.to(() => WelcomeScreen());
      return; // Exit function early
    }

    // Username is not null and not empty, navigate to BaseClass
    Get.to(() => BaseClass());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: (MediaQuery.of(context).size.height) * 0.45,
            // ),
            Center(
              child: Container(
                  width: Get.width * 0.6,
                  child: FadeInImage(
                      fadeInDuration: Duration(milliseconds: 100),
                      placeholder: MemoryImage(kTransparentImage),
                      image: const AssetImage(splashIcon))),
            ),
          ],
        ),
      ),
    );
  }
}
