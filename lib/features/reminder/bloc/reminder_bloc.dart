import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/reminder_model.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(ReminderInitial()) {
    on<SetReminderClickedEvent>(setReminderClickedEvent);
    on<RemindersInitialEvent>(remindersInitialEvent);
  }

  FutureOr<void> setReminderClickedEvent(
      SetReminderClickedEvent event, Emitter<ReminderState> emit) {
    emit(RemindersProcessingState());
    


  }

  FutureOr<void> remindersInitialEvent(
      RemindersInitialEvent event, Emitter<ReminderState> emit) {
    emit(ReminderInitial());
  }
}
