import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';

import '../../../functions/shared_preference_functions.dart';
import '../../add water drank/ui/drink_water.dart';
import '../../calories/ui/caloric_intake.dart';
import '../../calories/ui/calories.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double currentDailyCalorieGoal = 2500;
  double currentConsumedCalories = 0;
  double currentRemainingCalories = 0;

  String username = '';

  @override
  void initState() {
    super.initState();

    _updateCalorieData();
  }

  // Function to update calorie-related data
  Future<void> _updateCalorieData() async {
    double todayCaloricIntake = await getTodaysCaloricIntake();
    setState(() {
      currentConsumedCalories = todayCaloricIntake;
      currentRemainingCalories = currentDailyCalorieGoal - todayCaloricIntake;
    });
  }

  void getUserName() async {
    username = await getUsername();
  }

  void updateConsumedCalories(double newConsumedCalories) {
    setState(() {
      currentConsumedCalories = newConsumedCalories;
      currentRemainingCalories = currentDailyCalorieGoal - newConsumedCalories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            CaloricInformation(),
          );
        },
        backgroundColor: Colors.deepPurple,
        elevation: 4.0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Text(
                'Calories Summary',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: SfCircularChart(
                  legend: const Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                      dataSource: <ChartData>[
                        ChartData('Calories Consumed', currentConsumedCalories),
                        ChartData('Calories Remaining',
                            currentRemainingCalories.toPrecision(1)),
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
                              ? Colors.blue // Change color to blue
                              : Colors.red, // Change color to red
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
              ListTile(
                title: const Text('Intakes'),
                subtitle: const Text('See your intakes'),
                onTap: () {
                  Get.to(() => BlocProvider(
                        create: (context) => HomeBloc(),
                        child: CaloricIntakePage(
                          username: username,
                        ),
                      ));
                },
              ),
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
