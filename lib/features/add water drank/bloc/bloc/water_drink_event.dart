part of 'water_drink_bloc.dart';

@immutable
sealed class WaterDrinkEvent {}

class WaterDrinkLogEvent extends WaterDrinkEvent {
  final WaterLog waterLog;

  WaterDrinkLogEvent({required this.waterLog});
}

class WaterHistorySeeClickedEvent extends WaterDrinkEvent {}

class WaterDrinkHistoryEvent extends WaterDrinkEvent {}

class WaterDrinkLogDeleteEvent extends WaterDrinkEvent {
  final dynamic intakeID;

  WaterDrinkLogDeleteEvent({required this.intakeID});
}
