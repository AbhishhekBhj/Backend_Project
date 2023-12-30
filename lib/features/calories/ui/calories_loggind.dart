import 'dart:developer';

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:mygymbuddy/data/models/food_model.dart";
import "package:mygymbuddy/provider/themes/theme_provider.dart";
import "package:mygymbuddy/utils/shared%20preferences/sharedpreferences_manager.dart";
import "package:provider/provider.dart";

class CaloriesLoggingPage extends StatefulWidget {
  CaloriesLoggingPage({this.data, required this.callback});
  Function callback;

  @override
  State<CaloriesLoggingPage> createState() => _CaloriesLoggingPageState();
  FoodModel? data;
}

class _CaloriesLoggingPageState extends State<CaloriesLoggingPage> {
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  TextEditingController servingSizeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;

    var dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.deepPurpleAccent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            widget.callback();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Add Food",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Food Name: ${widget.data!.name}",
              style: const TextStyle(
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.02),

            Row(
              children: [
                const Text(
                  "Servings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
                    child: TextFormField(
                      style: TextStyle(
                          color: isDarkMode
                              ? Colors.black
                              : Colors.deepPurpleAccent),
                      controller: servingSizeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: isDarkMode
                                ? Colors.black
                                : Colors.deepPurpleAccent),
                        hintText: "Servings",
                        contentPadding: EdgeInsets.only(left: 35),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 20),
            SizedBox(height: Get.height * 0.01),

            SizedBox(height: Get.height * 0.01),

            _buildNutritionFact(
                "Calories Per Serving", '${widget.data!.caloriesPerServing}'),
            SizedBox(height: Get.height * 0.01),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "${dateTime.hour}:${dateTime.minute}",
                  style: const TextStyle(
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
                    FocusManager.instance.primaryFocus?.unfocus();
                    addFood();
                  },
                  style: isDarkMode
                      ? ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      : ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                  child: const Text(
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
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
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

    await sharedPreferenceManager.setCaloriesConsumedValue(
        caloriesConsumed); // this line is causing the issue

    double? calories = await sharedPreferenceManager.getCaloriesConsumedValue();
    log(calories.toString());
    widget.callback();
    Navigator.pop(context, caloriesConsumed);
  }
}
