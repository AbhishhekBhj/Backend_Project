import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/calories/ui/calories.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double currentDailyCalorieGoal = 2200;
  double currentConsumedCalories =
      1300; // These 3 values are dynamically changed later
  double currentRemainingCalories = 0;

  @override
  Widget build(BuildContext context) {
    currentRemainingCalories =
        currentDailyCalorieGoal - currentConsumedCalories;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Today',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    'Calories Summary',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 300.0,
                    child: SfCircularChart(
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                      ),
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          dataSource: <ChartData>[
                            ChartData(
                                'Calories Consumed', currentConsumedCalories),
                            ChartData(
                                'Calories Remaining', currentRemainingCalories),
                          ],
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.value,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.inside,
                          ),
                          // color for chart
                          pointColorMapper: (ChartData data, _) =>
                              data.category == 'Calories Consumed'
                                  ? MyColors.accentBlue
                                  : Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.0),
                  Text(
                    "Today's Calories Goal: $currentDailyCalorieGoal",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'Calories Consumed: $currentConsumedCalories',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'Calories Remaining: $currentRemainingCalories',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.to(CaloricInformation());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Search for Food",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.category, this.value);

  final String category;
  final double value;
}
