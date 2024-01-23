import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/reminder_model.dart';
import 'package:mygymbuddy/features/repo/reminders%20repo/reminders_repository.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(ReminderInitial()) {
    on<SetReminderClickedEvent>(setReminderClickedEvent);
    on<RemindersInitialEvent>(remindersInitialEvent);
  }

  FutureOr<void> setReminderClickedEvent(
      SetReminderClickedEvent event, Emitter<ReminderState> emit) async {
    emit(RemindersSetLoadingState());

    bool reminderSetSuccess = await RemindersRepository.setReminder(
      title: event.reminders.title,
      description: event.reminders.description,
      dueDate: event.reminders.dueDate,
      username: event.reminders.username,
    );

    if (reminderSetSuccess) {
      emit((RemindersSetSucessState()));
      Fluttertoast.showToast(msg: "Reminder set successfully");
    } else {
      log(event.reminders.username.toString());
      
      Fluttertoast.showToast(msg: "Reminder set failed");
    }
  }

  FutureOr<void> remindersInitialEvent(
      RemindersInitialEvent event, Emitter<ReminderState> emit) {
    emit(ReminderInitial());
  }
}
