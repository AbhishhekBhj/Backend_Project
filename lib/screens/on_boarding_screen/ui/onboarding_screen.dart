import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/screens/on_boarding_screen/ui/goal_screen.dart';
import 'package:mygymbuddy/screens/on_boarding_screen/ui/maintainance_calories_screen.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class OnBoardScreen extends StatelessWidget {
  OnBoardScreen({super.key});

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.arrow_forward),
        shape: CircleBorder(),
        backgroundColor: MyColors.lightPurple,
        onPressed: () {
          pageController.nextPage(
              duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
        },
        splashColor: MyColors.lightBlue,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(children: [
        SizedBox(
          height: screenSize.height * 0.30,
        ),
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Container(
                child: Center(
                  child: Column(children: [
                    Image.asset(
                      welcomeImage,
                      height: screenSize.width * 0.67,
                    ),
                    Text(
                      onBoardWelcomeText,
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      onBoardStartText,
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
                ),
              ),
              MaintainanceCaloriesPage(),
              GoalSettingScreen(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Align(
            alignment: Alignment.centerLeft, // align left most part of screen
            child: ElevatedButton(
              onPressed: () {
                pageController.previousPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceInOut);
              },
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(eccentricity: 0.12),
                  elevation: 6,
                  backgroundColor: MyColors.lightPurple,
                  foregroundColor: Colors.black),
              child: Icon(Icons.arrow_back),
            ),
          ),
        )
      ]),
    );
  }
}