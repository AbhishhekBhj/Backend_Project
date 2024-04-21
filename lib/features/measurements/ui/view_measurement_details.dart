//only include read for this action

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/graph/ui/measurement_graph.dart';
import 'package:mygymbuddy/features/measurements/bloc/bloc/measurements_bloc.dart';

class MeasurementDetails extends StatefulWidget {
  const MeasurementDetails({super.key});

  @override
  State<MeasurementDetails> createState() => _MeasurementDetailsState();
}

class _MeasurementDetailsState extends State<MeasurementDetails> {
  late MeasurementsBloc measurementsBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    measurementsBloc = BlocProvider.of<MeasurementsBloc>(context);
    measurementsBloc.add(MeasurementsHistoryViewEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Measurement Details'),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(const MeasurementGraph());
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text("View Graph")),
            ),
          ],
        ),
        body: BlocConsumer<MeasurementsBloc, MeasurementsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MeasurementHistoryViewLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is MeasurementHistoryViewSuccessState) {
              log(state.measurements.toString());
              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: Get.height * 0.05,
                  );
                },
                itemCount: state.measurements.length,
                itemBuilder: (context, index) {
                  final measurement = state.measurements[index];
                  return Card(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildField('Weight', measurement.weight),
                          _buildField('Height', measurement.height),
                          _buildField('Chest Size', measurement.chestSize),
                          _buildField('Waist Size', measurement.waistSize),
                          _buildField('Hip Size', measurement.hipSize),
                          _buildField('Left Arm', measurement.leftArm),
                          _buildField('Right Arm', measurement.rightArm),
                          _buildField(
                              'Left Quadricep', measurement.leftQuadricep),
                          _buildField(
                              'Right Quadricep', measurement.rightQuadricep),
                          _buildField('Left Calf', measurement.leftCalf),
                          _buildField('Right Calf', measurement.rightCalf),
                          _buildField('Left Forearm', measurement.leftForearm),
                          _buildField(
                              'Right Forearm', measurement.rightForearm),
                          _buildField('Notes', measurement.notes),
                          _buildField('Created At', measurement.createdAt),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is MeasurementHistoryViewFailureState) {
              return const Center(
                child: Text('Failed to load measurements'),
              );
            }
            return Container();
          },
        ));
  }

  Widget _buildField(String fieldName, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$fieldName:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _getDisplayValue(value),
              style: TextStyle(color: _getTextColor(value)),
            ),
          ),
        ],
      ),
    );
  }

  String _getDisplayValue(dynamic value) {
    if (value is double) {
      return value != 0 ? value.toString() : 'No value recorded';
    } else if (value is String) {
      return value.isNotEmpty ? value : 'No value recorded';
    }
    return 'Invalid value';
  }

  Color? _getTextColor(dynamic value) {
    if (value is double) {
      return value != 0 ? null : Colors.red;
    } else if (value is String) {
      return value.isNotEmpty ? null : Colors.red;
    }
    return Colors.red;
  }
}
