import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/calories/ui/calories.dart';
import 'package:mygymbuddy/features/setgoals/ui/goal_set.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:mygymbuddy/utils/shared%20preferences/sharedpreferences_manager.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double currentDailyCalorieGoal = 2500;
  double currentConsumedCalories = 0;
  double currentRemainingCalories = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<double> returnCaloriesConsumed(
      SharedPreferenceManager sharedPreferenceManager) async {
    double value = await sharedPreferenceManager.getCaloriesConsumedValue();
    log(value.toString());
    return value;
  }

  Future<void> initializeData() async {
    SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
    final consumedCalories =
        await returnCaloriesConsumed(sharedPreferenceManager);

    setState(() {
      currentConsumedCalories = consumedCalories;
      print(currentConsumedCalories);
      currentRemainingCalories =
          currentDailyCalorieGoal - currentConsumedCalories;
    });
  }

  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    currentRemainingCalories =
        currentDailyCalorieGoal - currentConsumedCalories;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(CaloricInformation(callback: initializeData));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.black),
                      ),
                      hintText: "Search for Food",
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Get.to(const GoalSetScreen());
                    },
                    child: const Text("Set Fitness Goals")),
              ),
              const Text(
                'Calories Summary',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: Get.height * 0.45,
                child: SfCircularChart(
                  legend: const Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                      dataSource: <ChartData>[
                        ChartData('Calories Consumed', currentConsumedCalories),
                        ChartData(
                            'Calories Remaining', currentRemainingCalories),
                      ],
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.value,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside,
                      ),
                      // color for chart
                      pointColorMapper: (ChartData data, _) =>
                          data.category == 'Calories Consumed'
                              ? MyColors.accentBlue
                              : Colors.redAccent,
                    ),
                  ],
                ),
              ),
              Text(
                "Today's Calories Goal: $currentDailyCalorieGoal",
                textAlign: TextAlign.center,
                style: contentTextStyle(),
              ),
              Text('Calories Consumed: $currentConsumedCalories',
                  textAlign: TextAlign.center, style: contentTextStyle()),
              Text('Calories Remaining: $currentRemainingCalories',
                  textAlign: TextAlign.center, style: contentTextStyle()),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle contentTextStyle() {
    return const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
  }
}

class ChartData {
  ChartData(this.category, this.value);

  final String category;
  final double value;
}
