import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        selectedFitnessGoal == -1;
      } else {
        selectedFitnessGoal = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Text(
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
                        print(selectedFitnessGoal);
                        widget.fitnessGoal = fitnessGoal[index];
                        print(widget.fitnessGoal);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        height: Get.height * 0.1,
                        width: Get.width * 0.4,
                        child: Text(fitnessGoal[index],
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            textAlign: TextAlign.center),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black),
                            color: Colors.black),
                      ),
                    ),
                    selectedFitnessGoal == index
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.blueAccent,
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
