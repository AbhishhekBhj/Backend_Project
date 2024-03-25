part of 'water_drink_bloc.dart';

@immutable
sealed class WaterDrinkState {}

final class WaterDrinkInitial extends WaterDrinkState {}

class WaterDrinkLogLoading extends WaterDrinkState {}

class WaterDrinkLogSuccessState extends WaterDrinkState{

}

class WaterDrinkLogFailureState extends WaterDrinkState{}


class WaterDrinkHistoryLoading extends WaterDrinkState {}
class WaterDrinkHistorySuccessState extends WaterDrinkState{
  final List<dynamic> waterLogs;

  WaterDrinkHistorySuccessState({required this.waterLogs});
}

class WaterDrinkHistoryFailureState extends WaterDrinkState{}



class WaterDrinkLogDeleteLoading extends WaterDrinkState {}
class WaterDrinkLogDeleteSuccessState extends WaterDrinkState{}
class WaterDrinkLogDeleteFailureState extends WaterDrinkState{}