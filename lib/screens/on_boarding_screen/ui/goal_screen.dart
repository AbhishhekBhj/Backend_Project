import 'package:flutter/material.dart';

class GoalSettingScreen extends StatefulWidget {
  const GoalSettingScreen({super.key});

  @override
  State<GoalSettingScreen> createState() => _GoalSettingScreenState();
}

class _GoalSettingScreenState extends State<GoalSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text(
                "Select Your Current Goal",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                child: Container(
                  color: Colors.green,
                  child: Text("Maintainance"),
                ),
              ),
              GestureDetector(
                child: Container(
                  color: Colors.purple,
                  child: Text("Bulking"),
                ),
              ),
              GestureDetector(
                child: Container(
                  color: Colors.black38,
                  child: Text("Cutting"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
