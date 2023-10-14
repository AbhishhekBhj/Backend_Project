import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/home/ui/common_ui.dart';
import 'package:mygymbuddy/screens/on_boarding_screen/ui/app_introduction.dart';
import 'package:mygymbuddy/screens/on_boarding_screen/ui/goal_screen.dart';
import 'package:mygymbuddy/screens/on_boarding_screen/ui/maintainance_calories_screen.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final pageController = PageController();

  bool firstPage = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: screenSize.height * 0.05,
        ),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
              onPressed: () {
                Get.off(BaseClass());
              },
              child: Text(
                "SKIP",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
        ),
        Expanded(
          flex: 6,
          child: PageView(
            onPageChanged: (val) {
              setState(() {
                firstPage = false;
              });
            },
            // physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Container(
                child: IntroScreen(screenSize: screenSize),
              ),
              AppScreen(),
              // MaintainanceCaloriesPage(),
              // GoalSettingScreen(),
            ],
          ),
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: 2,
          effect: SlideEffect(
              spacing: 8.0,
              radius: 4.0,
              dotWidth: 24.0,
              dotHeight: 16.0,
              paintStyle: PaintingStyle.stroke,
              strokeWidth: 1.5,
              dotColor: Colors.grey,
              activeDotColor: Colors.indigo),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.07),
          child: Align(
            alignment: Alignment.center, // align left most part of screen
            child: ElevatedButton(
                onPressed: () {
                  firstPage
                      ? pageController.nextPage(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.bounceInOut)
                      : Get.to(BaseClass());
                },
                style: ElevatedButton.styleFrom(
                    elevation: 6,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                child: firstPage ? Text("NEXT") : Text("BEGIN")),
          ),
        ),
      ]),
    );
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Image.asset(
          welcomeImage,
          height: screenSize.width * 0.67,
        ),
        Text(
          onBoardWelcomeText,
          style: TextStyle(
              // color: Colors.black38,
              fontSize: 35,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: Get.width * 0.85,
          child: Text(
            onBoardStartText,
            textAlign: TextAlign.justify,
            style: TextStyle(

                // color: Colors.black38,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        )
      ]),
    );
  }
}
