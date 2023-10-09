import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/exercise_entry.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(WorkoutInitial()) {
    on<WorkoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
