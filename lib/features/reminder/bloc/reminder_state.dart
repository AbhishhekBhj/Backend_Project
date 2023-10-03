part of 'reminder_bloc.dart';

@immutable
sealed class ReminderState {}

final class ReminderInitial extends ReminderState {}

final class RemindersProcessingState extends ReminderState{}

final class RemindersSetSucessState extends ReminderState{}

final class RemindersSetFailureState extends ReminderState{}