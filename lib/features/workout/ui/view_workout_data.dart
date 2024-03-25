import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mygymbuddy/data/models/workout_model.dart';
import 'package:mygymbuddy/features/workout/bloc/bloc/workout_bloc.dart';

class ViewWorkoutDetails extends StatefulWidget {
  const ViewWorkoutDetails({Key? key}) : super(key: key);

  @override
  State<ViewWorkoutDetails> createState() => _ViewWorkoutDetailsState();
}

class _ViewWorkoutDetailsState extends State<ViewWorkoutDetails> {
  late WorkoutBloc workoutBloc;

  @override
  void initState() {
    super.initState();
    workoutBloc = BlocProvider.of<WorkoutBloc>(context);
    workoutBloc.add(GetWorkoutHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Details"),
      ),
      body: BlocConsumer<WorkoutBloc, WorkoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is WorkoutHistoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WorkoutDataDeleteLoadingEvent) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WorkoutDataDeleteSuccessEvent) {
            workoutBloc.add(GetWorkoutHistoryEvent());
            // Rebuild the widget
          } else if (state is WorkoutHistoryLoadedState) {
            log("Workout History: ${state.workoutHistory.toString()}");
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.workoutHistory.length,
              itemBuilder: (BuildContext context, int index) {
                WorkoutModel workoutModel = state.workoutHistory[index];

                final date = DateTime.parse(workoutModel.createdAt!);
                final formattedDate = DateFormat.yMd().add_Hm().format(date);
                final today = DateTime.now();
                final isToday = today.year == date.year &&
                    today.month == date.month &&
                    today.day == date.day;

                return Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(formattedDate),
                    subtitle: Text(
                      "Sets: ${workoutModel.sets} Reps: ${workoutModel.reps} Weight: ${workoutModel.weight}",
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        if (isToday) {
                          workoutBloc.add(
                            DeleteWorkoutEvent(
                                workoutID: workoutModel.workoutID!),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "You can only delete today's workout data"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is WorkoutHistoryErrorState) {
            return Center(
              child: Text("Error loading workout history"),
            );
          }

          return Container();
        },
      ),
    );
  }
}
