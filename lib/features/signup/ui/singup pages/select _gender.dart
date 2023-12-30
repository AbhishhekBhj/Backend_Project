import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/colours/colours.dart';

class SelectGender extends StatefulWidget {
  SelectGender({super.key, required this.gender});

  String gender;
  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  List<String> genderString = ['Male', 'Female'];

  int selectedGender = -1;

  void toggleSelectedGender(int index) {
    setState(() {
      if (selectedGender == index) {
        selectedGender = -1;
      } else {
        selectedGender = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              'Select Gender',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Get.height * 0.15,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: genderString.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: height * 0.15, bottom: height * 0.05),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          toggleSelectedGender(index);

                          if (index == 0) {
                            widget.gender = genderString[index];
                          } else if (index == 1) {
                            widget.gender = genderString[index];
                          }
                          print(widget.gender);
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: height * 0.035),
                          height: height * 0.1,
                          width: width * 0.4,
                          child: Text(genderString[index],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              textAlign: TextAlign.center),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black),
                              color: Colors.black),
                        ),
                      ),
                      selectedGender == index
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
        ),
      ),
    );
  }
}
