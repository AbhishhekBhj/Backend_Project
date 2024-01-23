part of 'water_drink_bloc.dart';

@immutable
sealed class WaterDrinkState {}

final class WaterDrinkInitial extends WaterDrinkState {}

class WaterDrinkLogLoading extends WaterDrinkState {}

class WaterDrinkLogSuccessState extends WaterDrinkState{

}

class WaterDrinkLogFailureState extends WaterDrinkState{}