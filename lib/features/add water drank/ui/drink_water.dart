import 'package:flutter/material.dart';
import 'package:mygymbuddy/widgets/widgets.dart';
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

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
  }

  Future<void> loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadUserWaterDrank();
  }

  Future<void> saveUserWaterDrank() async {
    await sharedPreferences.setDouble('waterDrankToday', waterDrankToday);
  }

  Future<void> loadUserWaterDrank() async {
    setState(() {
      waterDrankToday = sharedPreferences.getDouble("waterDrankToday") ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    waterLeftToDrink = waterAmountToDrink - waterDrankToday;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInputDialog();
        },
        child: Icon(Icons.add),
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
                )
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
                Navigator.of(context).pop(userInput);
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
