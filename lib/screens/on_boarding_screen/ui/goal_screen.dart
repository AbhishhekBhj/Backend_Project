import 'package:flutter/material.dart';
import 'package:mygymbuddy/texts/texts.dart';

class GoalSettingScreen extends StatefulWidget {
  const GoalSettingScreen({Key? key}) : super(key: key);

  @override
  State<GoalSettingScreen> createState() => _GoalSettingScreenState();
}

class _GoalSettingScreenState extends State<GoalSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          children: [
            Text(
              aSelectGoal,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("You selected Maintainance Calories");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(aMaintainace),
            ),
            SizedBox(height: 20), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                print("You selected Bulking Calories");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(aBulking),
            ),
            SizedBox(height: 20), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                print("You selected Cutting Calories");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black26,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(aCutting),
            ),
          ],
        ),
      ),
    );
  }
}
