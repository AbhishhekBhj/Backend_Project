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
    startTimer();
    super.initState();
  }

  startTimer() {
    timer = Timer(
      Duration(seconds: 2),
      () {
        print('hi');
        checkUserNameAndNavigate();
      },
    );
  }

  checkUserNameAndNavigate() async {
    String? username = await getUsername();
    log(username!);

    // Check whether to navigate to Signup Page or Home Page
    if (username.isNotEmpty) {
      Get.offAll(() => WelcomeScreen());
    } else {
      Get.offAll(() => WelcomeScreen());
    }
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
