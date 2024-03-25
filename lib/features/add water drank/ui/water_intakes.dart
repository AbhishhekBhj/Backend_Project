import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygymbuddy/features/add%20water%20drank/bloc/bloc/water_drink_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class WaterIntakes extends StatefulWidget {
  const WaterIntakes({super.key});

  @override
  State<WaterIntakes> createState() => _WaterIntakesState();
}

class _WaterIntakesState extends State<WaterIntakes> {
  late WaterDrinkBloc _waterDrinkBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _waterDrinkBloc = BlocProvider.of<WaterDrinkBloc>(context);
    _waterDrinkBloc.add(WaterDrinkHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Intakes'),
      ),
      body: BlocBuilder<WaterDrinkBloc, WaterDrinkState>(
        builder: (context, state) {
          if (state is WaterDrinkHistoryLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is WaterDrinkHistorySuccessState) {
            final waterLogs = state.waterLogs;
            if (waterLogs.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              return BlocListener<WaterDrinkBloc, WaterDrinkState>(
                listener: (context, state) {
                  if (state is WaterDrinkLogDeleteSuccessState) {
                    _waterDrinkBloc.add(WaterDrinkHistoryEvent());
                  }
                },
                child: WaterDataWidget(
                  waterLogs: waterLogs,
                  waterDrinkBloc: _waterDrinkBloc,
                ),
              );
            }
          }

          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}

class WaterDataWidget extends StatelessWidget {
  const WaterDataWidget(
      {super.key, required this.waterLogs, required this.waterDrinkBloc});

  final List waterLogs;

  final WaterDrinkBloc waterDrinkBloc;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: waterLogs.length,
      itemBuilder: (context, index) {
        var waterLog = waterLogs[index];
        var id = waterLog["id"];
        var volume = waterLog["volume"];
        var timestamp = waterLog["timestamp"];
        var date = DateFormat.yMMMd().format(DateTime.parse(timestamp));
        var time = DateFormat.jm().format(DateTime.parse(timestamp));

        //check if the log is for today
        var today = DateTime.now();
        var isToday = today.day == DateTime.parse(timestamp).day &&
            today.month == DateTime.parse(timestamp).month &&
            today.year == DateTime.parse(timestamp).year;

        return Card(
          elevation: 4,
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text('Volume: $volume ml,$id'),
            subtitle: Text('Date: $date, Time: $time'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (!isToday) {
                  Fluttertoast.showToast(
                      msg: "Cannot delete past logs",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  waterDrinkBloc
                      .add(WaterDrinkLogDeleteEvent(intakeID: waterLog["id"]));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
