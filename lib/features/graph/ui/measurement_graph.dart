import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/data/models/measurement_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/features/measurements/bloc/bloc/measurements_bloc.dart';

class MeasurementGraph extends StatefulWidget {
  const MeasurementGraph({Key? key}) : super(key: key);

  @override
  State<MeasurementGraph> createState() => _MeasurementGraphState();
}

class _MeasurementGraphState extends State<MeasurementGraph> {
  late MeasurementsBloc measurementsBloc;
  String selectedMeasurement = 'Weight'; // Default selected measurement

  @override
  void initState() {
    super.initState();
    measurementsBloc = BlocProvider.of<MeasurementsBloc>(context);
    measurementsBloc.add(MeasurementsHistoryViewEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measurement Graph'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildButtons(), // Display buttons to select measurements
          Expanded(
            child: BlocBuilder<MeasurementsBloc, MeasurementsState>(
              builder: (context, state) {
                if (state is MeasurementHistoryViewLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MeasurementHistoryViewSuccessState) {
                  log(state.measurements.toString());
                  List<BodyMeasurement> measurements = state.measurements;
                  List<BodyMeasurement> filteredMeasurements =
                      _filterMeasurements(measurements);
                  return _buildChart(filteredMeasurements);
                } else if (state is MeasurementHistoryViewFailureState) {
                  return Center(
                    child: Text('Failed to load measurements'),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton('Weight'),
          _buildButton('Height'),
          _buildButton('Chest Size'),
          _buildButton('Waist Size'),
          _buildButton('Hip Size'),
          _buildButton('Left Arm'),
          _buildButton('Right Arm'),
          _buildButton('Left Quadricep'),
          _buildButton('Right Quadricep'),
          _buildButton('Left Calf'),
          _buildButton('Right Calf'),
          _buildButton('Left Forearm'),
          _buildButton('Right Forearm'),
        ],
      ),
    );
  }

  Widget _buildButton(String measurement) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedMeasurement = measurement;
        });
      },
      child: Text(measurement),
    );
  }

  Widget _buildChart(List<BodyMeasurement> measurements) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        title: AxisTitle(
            text: measurements.length > 0
                ? measurements[0].createdAt.toString()
                : ''),
        labelRotation: -45,
        labelsExtent: 50,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
            text:
                selectedMeasurement), // Use selected measurement as Y-axis title
      ),
      series: _buildSeries(measurements),
    );
  }

  List<BodyMeasurement> _filterMeasurements(
      List<BodyMeasurement> measurements) {
    // Return all measurements if 'Height' is selected
    if (selectedMeasurement == 'Height') {
      return measurements;
    }

    // Filter measurements based on the selected measurement
    return measurements
        .where((measurement) => selectedMeasurement == 'Weight'
            ? measurement.weight != null
            : selectedMeasurement == 'Chest Size'
                ? measurement.chestSize != null
                : selectedMeasurement == 'Waist Size'
                    ? measurement.waistSize != null
                    : selectedMeasurement == 'Hip Size'
                        ? measurement.hipSize != null
                        : selectedMeasurement == 'Left Arm'
                            ? measurement.leftArm != null
                            : selectedMeasurement == 'Right Arm'
                                ? measurement.rightArm != null
                                : selectedMeasurement == 'Left Quadricep'
                                    ? measurement.leftQuadricep != null
                                    : selectedMeasurement == 'Right Quadricep'
                                        ? measurement.rightQuadricep != null
                                        : selectedMeasurement == 'Left Calf'
                                            ? measurement.leftCalf != null
                                            : selectedMeasurement ==
                                                    'Right Calf'
                                                ? measurement.rightCalf != null
                                                : selectedMeasurement ==
                                                        'Left Forearm'
                                                    ? measurement.leftForearm !=
                                                        null
                                                    : selectedMeasurement ==
                                                            'Right Forearm'
                                                        ? measurement
                                                                .rightForearm !=
                                                            null
                                                        : false)
        .toList();
  }

  List<LineSeries<BodyMeasurement, String>> _buildSeries(
    List<BodyMeasurement> measurements,
  ) {
    measurements.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

    final List<LineSeries<BodyMeasurement, String>> seriesList = [];

    // Define a list of measurement types
    final List<String> measurementTypes = [
      'Weight',
      'Height',
      'Chest Size',
      'Waist Size',
      'Hip Size',
      'Left Arm',
      'Right Arm',
      'Left Quadricep',
      'Right Quadricep',
      'Left Calf',
      'Right Calf',
      'Left Forearm',
      'Right Forearm',
    ];

    // Add series for each measurement type
    for (String measurementType in measurementTypes) {
      void addSeries(
        String fieldName,
        dynamic Function(BodyMeasurement) valueMapper,
      ) {
        seriesList.add(
          LineSeries<BodyMeasurement, String>(
            dataSource: measurements,
            xValueMapper: (measurement, _) => measurement.createdAt.toString(),
            yValueMapper: (measurement, _) => valueMapper(measurement),
            name: fieldName,
          ),
        );
      }

      // Add series for the current measurement type
      switch (measurementType) {
        case 'Weight':
          addSeries('Weight', (measurement) => measurement.weight ?? 0);
          break;
        case 'Height':
          addSeries('Height', (measurement) => measurement.height ?? 0);
          break;
        case 'Chest Size':
          addSeries('Chest Size', (measurement) => measurement.chestSize ?? 0);
          break;
        case 'Waist Size':
          addSeries('Waist Size', (measurement) => measurement.waistSize ?? 0);
          break;
        case 'Hip Size':
          addSeries('Hip Size', (measurement) => measurement.hipSize ?? 0);
          break;
        case 'Left Arm':
          addSeries('Left Arm', (measurement) => measurement.leftArm ?? 0);
          break;
        case 'Right Arm':
          addSeries('Right Arm', (measurement) => measurement.rightArm ?? 0);
          break;
        case 'Left Quadricep':
          addSeries('Left Quadricep',
              (measurement) => measurement.leftQuadricep ?? 0);
          break;
        case 'Right Quadricep':
          addSeries('Right Quadricep',
              (measurement) => measurement.rightQuadricep ?? 0);
          break;
        case 'Left Calf':
          addSeries('Left Calf', (measurement) => measurement.leftCalf ?? 0);
          break;
        case 'Right Calf':
          addSeries('Right Calf', (measurement) => measurement.rightCalf ?? 0);
          break;
        case 'Left Forearm':
          addSeries(
              'Left Forearm', (measurement) => measurement.leftForearm ?? 0);
          break;
        case 'Right Forearm':
          addSeries(
              'Right Forearm', (measurement) => measurement.rightForearm ?? 0);
          break;
        default:
          break;
      }
    }

    return seriesList;
  }
}
