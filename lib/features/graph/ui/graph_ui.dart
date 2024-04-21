import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../calories/bloc/calories_bloc.dart';

class Graph extends StatelessWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caloric Intake Graph'),
        centerTitle: true,
      ),
      body: BlocBuilder<CaloriesBloc, CaloriesState>(
        builder: (context, state) {
          if (state is CaloriesIntakeRequestLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CaloriesIntakeRequestSuccessState) {
            if (state.caloricIntakeList == null) {
              return Center(
                child: Text('No data available'),
              );
            }

            List<dynamic> caloricIntakeList = state.caloricIntakeList!;

            return Padding(
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
                      BarSeries<Map<String, dynamic>, String>(
                        enableTooltip: true,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          showCumulativeValues: true,
                        ),
                        pointColorMapper: (datum, index) {
                          double? caloricIntake =
                              datum['calories_consumed'] as double?;
                          if (caloricIntake != null && caloricIntake > 2000) {
                            return Colors.red;
                          } else {
                            return Colors.green;
                          }
                        },
                        dataSource:
                            caloricIntakeList.cast<Map<String, dynamic>>(),
                        xValueMapper: (datum, _) =>
                            datum['timestamp'].toString(),
                        yValueMapper: (datum, _) =>
                            datum['calories_consumed'] as double?,
                        name: 'Caloric Intake',
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (state is CaloriesIntakeRequestErrorState) {
            return Center(
              child: Text('Error fetching data'),
            );
          } else {
            return Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }
}
