import 'dart:developer';

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:mygymbuddy/data/models/food_model.dart";
import "package:mygymbuddy/utils/shared%20preferences/sharedpreferences_manager.dart";
import "package:shared_preferences/shared_preferences.dart";

class CaloriesLoggingPage extends StatefulWidget {
  CaloriesLoggingPage({this.data, required this.callback});
  Function callback;

  @override
  State<CaloriesLoggingPage> createState() => _CaloriesLoggingPageState();
  FoodModel? data;
}

class _CaloriesLoggingPageState extends State<CaloriesLoggingPage> {
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  bool isDarkMode = false;
  DarkMode() async {
    var prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkTheme')!;
  }

  TextEditingController servingSizeController = TextEditingController();

  @override
  void initState() {
    DarkMode();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            widget.callback();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Add Food",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Food Name: ${widget.data!.name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: Get.height * 0.02),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Serving Size ${widget.data!.servingSize} gm",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Text(
              "Servings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            TextFormField(
              controller: servingSizeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: isDarkMode ? Colors.black : Colors.blueGrey),
                hintText: "Number of servings you consume",
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            // SizedBox(height: 20),
            SizedBox(height: Get.height * 0.01),

            SizedBox(height: Get.height * 0.01),

            Text(
              "Nutrition Facts",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: Get.height * 0.01),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNutritionFact("Calories Per Serving",
                    '${widget.data!.caloriesPerServing}'),
                _buildNutritionFact(
                    "Protein", "${widget.data!.proteinPerServing}"),
              ],
            ),
            SizedBox(height: Get.height * 0.01),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "${dateTime.hour}:${dateTime.minute}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.01),

            Center(
              child: Container(
                width: Get.width * 0.45,
                child: ElevatedButton(
                  onPressed: () async {
                    addFood();
                  },
                  style: isDarkMode
                      ? ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      : ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                  child: Text(
                    "LOG FOOD",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionFact(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void addFood() async {
    double serving = double.parse(servingSizeController.text);
    double? servingSizeConsumed = widget.data!.servingSize! * serving;

    double? proteinConsumed = widget.data!.proteinPerServing! * serving;
    double? caloriesConsumed = widget.data!.caloriesPerServing! * serving;

    await sharedPreferenceManager.setCaloriesConsumedValue(caloriesConsumed);

    double? calories = await sharedPreferenceManager.getCaloriesConsumedValue();
    log(calories.toString());
    widget.callback();
    Navigator.pop(context, caloriesConsumed);
  }

  // Future<bool> isDarkMode() async {
  //   SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  //   bool? darkMode = await sharedPreferenceManager.getDarkTheme();

  //   if (darkMode != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
