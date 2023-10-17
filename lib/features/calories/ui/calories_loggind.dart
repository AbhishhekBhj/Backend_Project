import "dart:developer";

import "package:flutter/material.dart";
import "package:mygymbuddy/data/models/food_model.dart";
import "package:mygymbuddy/utils/shared%20preferences/sharedpreferences_manager.dart";
import "package:shared_preferences/shared_preferences.dart";

class CaloriesLoggingPage extends StatefulWidget {
  CaloriesLoggingPage({this.data});

  @override
  State<CaloriesLoggingPage> createState() => _CaloriesLoggingPageState();
  FoodModel? data;
}

class _CaloriesLoggingPageState extends State<CaloriesLoggingPage> {
  bool isDarkMode = false;
  DarkMode() async {
    var prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkTheme')!;
  }

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
              "Food Name ${widget.data!.name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Servings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixText: "eg 1",
                hintText: "Number of Servings",
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Serving Size ${widget.data!.servingSize}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "100g",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Nutrition Facts",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNutritionFact("Calories Per Serving",
                    '${widget.data!.caloriesPerServing}'),
                _buildNutritionFact(
                    "Protein", "${widget.data!.proteinPerServing}"),
              ],
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {},
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
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
              child: Text(
                "Log Food",
                style: TextStyle(
                  fontSize: 20,
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
