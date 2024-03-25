import 'dart:async';

import 'package:bloc/bloc.dart';
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
  }

  FutureOr<void> finishWorkoutEvent(
      FinishWorkoutEvent event, Emitter<WorkoutState> emit) async {
    emit(WorkoutPostLoadingState());

    try{
      List<WorkoutModel> workoutModel =
        await WorkoutRepository.postWorkout(event.workoutEntry);

    if (workoutModel.isNotEmpty) {
      emit(WorkoutPostLoadedSuccessState());
    } else {
      emit(WorkoutPostLoadedErrorState());
    }
    } catch (e) {
      emit(WorkoutPostLoadedErrorState());
    }
  }
}
