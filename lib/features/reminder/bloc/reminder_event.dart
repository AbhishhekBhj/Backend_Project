part of 'reminder_bloc.dart';

@immutable
sealed class ReminderEvent {}

class RemindersInitialEvent extends ReminderEvent {
  
}

class SetReminderClickedEvent extends ReminderEvent {
  final Reminder reminders;

  SetReminderClickedEvent(this.reminders);
}
