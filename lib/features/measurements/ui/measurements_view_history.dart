import 'package:flutter/material.dart';
import 'package:mygymbuddy/data/models/sample_body_data.dart';
import 'package:mygymbuddy/features/add%20water%20drank/ui/drink_water.dart';
import 'package:mygymbuddy/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewMeasurementsHistory extends StatefulWidget {
  const ViewMeasurementsHistory({Key? key}) : super(key: key);

  @override
  State<ViewMeasurementsHistory> createState() =>
      _ViewMeasurementsHistoryState();
}

class _ViewMeasurementsHistoryState extends State<ViewMeasurementsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        HeaderWidget(text: "Body Measurements Graph"),
        Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
              // Initialize line series
              LineSeries<ChartData, String>(
                  dataSource: [
                    // Bind data source
                    ChartData('Jan', 12),
                    ChartData('Feb', 12.2),
                    ChartData('Mar', 12.3),
                    ChartData('Apr', 12.4),
                    ChartData('May', 12.5)
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y)
            ]))),
      ],
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
