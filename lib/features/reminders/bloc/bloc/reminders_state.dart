part of 'reminders_bloc.dart';

@immutable
sealed class RemindersState {}

final class RemindersInitial extends RemindersState {}

final class RemindersActionState extends RemindersState{}

final class RemindersLoadingState extends RemindersState{}

final class RemindersSuccessState extends RemindersState{}

final class RemindersFailureState extends RemindersState{}
