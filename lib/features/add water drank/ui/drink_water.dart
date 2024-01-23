import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/data/models/log_water_model.dart';
import 'package:mygymbuddy/features/add%20water%20drank/bloc/bloc/water_drink_bloc.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  Future<void> saveUserWaterDrank() async {
    await sharedPreferences.setDouble('waterDrankToday', waterDrankToday);
  }

  Future<void> loadUserWaterDrank() async {
    setState(() {
      waterDrankToday = sharedPreferences.getDouble("waterDrankToday") ?? 0;
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
        child: Icon(Icons.add),
        foregroundColor: themeProvider.getTheme == themeProvider.darkTheme
            ? Colors.blue
            : Colors.white,
        backgroundColor: themeProvider.getTheme == themeProvider.darkTheme
            ? Colors.white
            : Colors.lightBlue,
        shape: CircleBorder(),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
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
                    legend: Legend(
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
                        dataLabelSettings: DataLabelSettings(
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
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Water Drank: $waterDrankToday ml',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Water Left: $waterLeftToDrink ml',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle homeTextStyle() =>
      TextStyle(fontSize: 27, fontWeight: FontWeight.bold);

  Future<void> _showInputDialog() async {
    double? userInput = await showDialog<double?>(
      context: context,
      builder: (context) {
        double userInput = 0;
        return AlertDialog(
          title: Text("Input amount of water that you drank in ml:"),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              userInput = double.parse(value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                log(username);
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
                waterDrinkBloc.add(WaterDrinkLogEvent(
                    waterLog: WaterLog(
                  username: username,
                  volume: double.parse(userInput.toString()),
                )));
              },
              child: Text('Save'),
            )
          ],
        );
      },
    );

    if (userInput != null && userInput >= 0) {
      setState(() {
        waterDrankToday += userInput;
      });
      saveUserWaterDrank(); // Save the updated value
    }
    if (userInput! > waterAmountToDrink) {
      setState(() {});
    }
  }
}

class ChartData {
  ChartData(this.category, this.value);

  final String category;
  final double value;
}
