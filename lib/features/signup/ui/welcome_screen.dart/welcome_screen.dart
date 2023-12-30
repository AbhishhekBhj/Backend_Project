import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/signup/ui/signup_page_view.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

import 'demo_login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.09,
                ),
                Container(
                  width: Get.width * 0.8,
                  child: Image.asset(splashIcon),
                ),
                SizedBox(
                  height: Get.height * 0.15,
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(DemoLoginPage());
                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF0DA0FF),
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.1, vertical: 20),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(SignupPageView());
                      },
                      child: Text('Signup'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF0DA0FF),
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.1, vertical: 20),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
