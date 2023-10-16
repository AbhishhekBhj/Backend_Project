import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/screens/on_boarding_screen/ui/goal_screen.dart';
import 'package:mygymbuddy/screens/on_boarding_screen/ui/maintainance_calories_screen.dart';

class GoalSetScreen extends StatefulWidget {
  const GoalSetScreen({super.key});

  @override
  State<GoalSetScreen> createState() => _GoalSetScreenState();
}

class _GoalSetScreenState extends State<GoalSetScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0; // Initialize currentPage here
  double _progress = 0;
  String fitnessGoal = "";
  @override
  void initState() {
    super.initState();
    _progress = 1 / 2; //Initial progress for the first page
  }

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: LinearProgressIndicator(
            minHeight: 4.0,
            value: _progress,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: Get.height * 0.05,
          ),
          SizedBox(
            height: Get.height,
            child: PageView(
              onPageChanged: (int value) {
                setState(() {
                  currentPage = value;
                  _progress = (currentPage + 1) / 2;
                });
              },
              controller: pageController,
              children: [MaintainanceCaloriesPage(), GoalSettingScreen()],
            ),
          )
        ],
      ),
      bottomSheet: Container(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              child: Text("CONTINUE"),
              onPressed: () {
                pageController.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 1, color: Colors.white),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
