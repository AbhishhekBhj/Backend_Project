// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calories_bloc.dart';

@immutable
sealed class CaloriesEvent {}

class CaloriesInitalEvent extends CaloriesEvent {}

class CaloriesSearchByNameEvent extends CaloriesEvent {
  final String foodname;
  CaloriesSearchByNameEvent({
    required this.foodname,
  });
}

class CaloriesConsumedLogEvent extends CaloriesEvent {
  final CaloriesLog caloriesLog;
  CaloriesConsumedLogEvent({
    required this.caloriesLog,
  });
}

class CaloriesLogDeleteEvent extends CaloriesEvent {
  final dynamic id;
  CaloriesLogDeleteEvent({
    required this.id,
  });
}

class CaloriesIntakeRequestEvent extends CaloriesEvent {}
