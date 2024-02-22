import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/graph/models/graph_models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CaloricIntakeModel> caloricIntakeList =
        CaloricIntakeModel.sampleDataList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Caloric Intake Graph'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: Get.width,
            height: Get.height * 0.9,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
              series: <ChartSeries>[
                BarSeries<CaloricIntakeModel, String>(
                  enableTooltip: true,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true, showCumulativeValues: true),
                  pointColorMapper: (datum, index) {
                    if (datum.caloricIntake > 2000) {
                      return Colors.red;
                    } else {
                      return Colors.green;
                    }
                  },
                  dataSource: caloricIntakeList,
                  xValueMapper: (CaloricIntakeModel intake, _) => intake.date,
                  yValueMapper: (CaloricIntakeModel intake, _) =>
                      intake.caloricIntake,
                  name: 'Caloric Intake',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
