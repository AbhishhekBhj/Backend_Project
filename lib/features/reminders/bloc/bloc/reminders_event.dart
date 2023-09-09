part of 'reminders_bloc.dart';

@immutable
sealed class RemindersEvent {}

class RemindersInitialEvent extends RemindersEvent{}

class SetRemindersButtonClickedEvent extends RemindersEvent{}
