import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SelectFitnessGoal extends StatefulWidget {
  SelectFitnessGoal({Key? key, required this.fitnessGoal}) : super(key: key);

  String fitnessGoal;
  @override
  State<SelectFitnessGoal> createState() => _SelectFitnessGoalState();
}

class _SelectFitnessGoalState extends State<SelectFitnessGoal> {
  int selectedFitnessGoal = -1;
  List<String> fitnessGoal = ['Bulking', "Cutting", "Maintainance"];

  void toggleFitnessGoal(int index) {
    setState(() {
      if (selectedFitnessGoal == index) {
        selectedFitnessGoal = -1;
      } else {
        selectedFitnessGoal = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          const Text(
            'Select Fitness Goal',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          ListView.builder(
            shrinkWrap: true,
            itemCount: fitnessGoal.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: Get.height * 0.15, bottom: Get.height * 0.05),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        toggleFitnessGoal(index);
                        if (selectedFitnessGoal == index) {
                          widget.fitnessGoal = fitnessGoal[index];
                        } else {
                          widget.fitnessGoal = "";
                        }
                        log(widget.fitnessGoal);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        height: Get.height * 0.1,
                        width: Get.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color:
                                    isDarkMode ? Colors.black : Colors.white),
                            color: isDarkMode
                                ? Colors.grey.shade400
                                : Colors.black),
                        child: Text(fitnessGoal[index],
                            style: TextStyle(
                                color: isDarkMode ? Colors.black : Colors.white,
                                fontSize: 15),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    selectedFitnessGoal == index
                        ? Icon(
                            Icons.check_circle,
                            color: isDarkMode ? Colors.white : Colors.black,
                          )
                        : Container()
                  ],
                ),
              );
            },
          )
        ],
      )),
    );
  }
}
