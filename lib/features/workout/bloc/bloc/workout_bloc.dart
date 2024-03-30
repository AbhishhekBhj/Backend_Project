import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/exercise_entry.dart';
import 'package:mygymbuddy/data/models/home_model.dart';
import 'package:mygymbuddy/features/repo/workout%20repo/workout_repository.dart';

import '../../../../data/models/workout_model.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(WorkoutInitial()) {
    on<FinishWorkoutEvent>(finishWorkoutEvent);
    on<GetWorkoutHistoryEvent>(getWorkoutHistoryEvent);
    on<DeleteWorkoutEvent>(deleteWorkoutEvent);
  }

  FutureOr<void> finishWorkoutEvent(
      FinishWorkoutEvent event, Emitter<WorkoutState> emit) async {
    emit(WorkoutPostLoadingState());

    log("Workout entry: ${event.workoutEntry.toString()}");

    try {
      List<WorkoutModel> workoutModel =
          await WorkoutRepository.postWorkout(event.workoutEntry);

      if (workoutModel.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Workout posted successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(WorkoutPostLoadedSuccessState());
      } else {
        Fluttertoast.showToast(
            msg: "Workout post unsuccessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        emit(WorkoutPostLoadedErrorState());
      }
    } catch (e) {
      emit(WorkoutPostLoadedErrorState());
    }
  }

  FutureOr<void> getWorkoutHistoryEvent(
      GetWorkoutHistoryEvent event, Emitter<WorkoutState> emit) async {
    emit(WorkoutHistoryLoadingState());

    try {
      List<dynamic> workoutHistoryData =
          await WorkoutHistoryRepository.getWorkoutHistory();

      if (workoutHistoryData != null) {
        emit(WorkoutHistoryLoadedState(workoutHistory: workoutHistoryData));
      } else {
        emit(WorkoutHistoryErrorState(
            errorMessage: "Error loading workout history. Please try again."));
      }
    } catch (e) {
      emit(WorkoutHistoryErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> deleteWorkoutEvent(
      DeleteWorkoutEvent event, Emitter<WorkoutState> emit) async {
    emit(WorkoutDataDeleteLoadingEvent());

    try {
      bool isDeleted = await DeleteWorkoutObjectRepository.deleteWorkoutObject(
        workoutID: event.workoutID,
      );

      if (isDeleted) {
        Fluttertoast.showToast(
            msg: "Workout deleted successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(WorkoutDataDeleteSuccessEvent());
      } else {
        Fluttertoast.showToast(
            msg: "Workout delete unsuccessful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        emit(WorkoutDataDeleteErrorEvent());
      }
    } catch (e) {
      emit(WorkoutDataDeleteErrorEvent());
    }
  }
}
