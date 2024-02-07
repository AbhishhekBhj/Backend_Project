import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/screens/splash_screen/splash_screen.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/img/nointernet.gif'),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(SplashScreen());
                },
                child: Text('Retry'))
          ],
        ),
      ),
    );
  }
}
