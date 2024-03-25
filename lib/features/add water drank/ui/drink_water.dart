import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/data/models/log_water_model.dart';
import 'package:mygymbuddy/features/add%20water%20drank/bloc/bloc/water_drink_bloc.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../measurements/ui/measurements_view_history.dart';
import 'water_intakes.dart';

class DrinkWater extends StatefulWidget {
  const DrinkWater({Key? key}) : super(key: key);

  @override
  _DrinkWaterState createState() => _DrinkWaterState();
}

class _DrinkWaterState extends State<DrinkWater> {
  double waterAmountToDrink = 3000;
  double waterDrankToday = 0;
  double waterLeftToDrink = 0;
  late SharedPreferences sharedPreferences;
  late String username;
  WaterDrinkBloc waterDrinkBloc = WaterDrinkBloc();

  final TextEditingController waterAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
  }

  Future<void> loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadUserWaterDrank();
    loadUserName();
  }

  Future<void> loadUserWaterDrank() async {
    double todyWaterDrank = await getTodaysWaterIntake();
    setState(() {
      waterDrankToday = todyWaterDrank;
    });
  }

  Future<void> loadUserName() async {
    setState(() {
      username = sharedPreferences.getString("username") ?? 'test';
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final screenSize = MediaQuery.of(context).size;
    waterLeftToDrink = waterAmountToDrink - waterDrankToday;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInputDialog();
        },
        foregroundColor: themeProvider.getTheme == themeProvider.darkTheme
            ? Colors.blue
            : Colors.white,
        backgroundColor: themeProvider.getTheme == themeProvider.darkTheme
            ? Colors.white
            : Colors.lightBlue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "WATER INTAKE REPORT",
                  style: homeTextStyle(),
                ),
                Container(
                  height: screenSize.height * 0.40,
                  child: SfCircularChart(
                    legend: const Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                    ),
                    series: <CircularSeries>[
                      PieSeries<ChartData, String>(
                        dataSource: <ChartData>[
                          ChartData('Water Drank Today', waterDrankToday),
                          ChartData('Water Left To Drink', waterLeftToDrink),
                        ],
                        xValueMapper: (ChartData data, _) => data.category,
                        yValueMapper: (ChartData data, _) => data.value,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.inside,
                        ),
                        // color for chart
                        pointColorMapper: (ChartData data, _) =>
                            data.category == 'Water Left To Drink'
                                ? Colors.red
                                : Colors.lightBlue,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Today's Water Goal: $waterAmountToDrink ml",
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Water Drank: $waterDrankToday ml',
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Water Left: $waterLeftToDrink ml',
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: const Text("Water Intake History"),
                  subtitle: const Text("See your water intake history"),
                  onTap: () {
                    Get.to(() => WaterIntakes());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle homeTextStyle() =>
      const TextStyle(fontSize: 33, fontWeight: FontWeight.bold);

  // void _showInputDialog() {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return Padding(
  //         padding: MediaQuery.of(context).viewInsets,
  //         child: Container(
  //           height: Get.height * 0.25,
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             children: [
  //               TextField(
  //                 controller: waterAmountController,
  //                 keyboardType: TextInputType.number,
  //                 decoration: const InputDecoration(
  //                   labelText: "Enter Water Amount",
  //                   hintText: "Enter Water Amount",
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   if (waterAmountController.text.isNotEmpty) {
  //                     Navigator.pop(context);
  //                     FocusScope.of(context).unfocus();
  //                     waterDrinkBloc.add(WaterDrinkLogEvent(
  //                         waterLog: WaterLog(
  //                             username: UserDataManager.userData['user_id'],
  //                             volume:
  //                                 double.parse(waterAmountController.text))));
  //                   }
  //                 },
  //                 child: Container(
  //                     width: Get.width * 0.5,
  //                     height: Get.height * 0.05,
  //                     decoration: BoxDecoration(
  //                         color: Colors.blue,
  //                         borderRadius: BorderRadius.circular(10)),
  //                     child: Center(
  //                         child: const Text(
  //                       "Save",
  //                       style: TextStyle(color: Colors.white),
  //                     ))),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showInputDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: Get.height * 0.25,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: waterAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Enter Water Amount",
                    hintText: "Enter Water Amount",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (waterAmountController.text.isNotEmpty) {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                      waterDrinkBloc.add(WaterDrinkLogEvent(
                          waterLog: WaterLog(
                              username: UserDataManager.userData['user_id'],
                              volume:
                                  double.parse(waterAmountController.text))));
                      setState(() {
                        waterDrankToday +=
                            double.parse(waterAmountController.text);
                        waterLeftToDrink = waterAmountToDrink - waterDrankToday;
                      });
                    }
                  },
                  child: Container(
                    width: Get.width * 0.5,
                    height: Get.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChartData {
  ChartData(this.category, this.value);

  final String category;
  final double value;
}
