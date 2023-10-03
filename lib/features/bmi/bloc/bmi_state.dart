part of 'bmi_bloc.dart';

@immutable
sealed class BmiState {}

final class BmiInitial extends BmiState {}

final class BMIActionState extends BmiState {}

final class BMILoadingState extends BmiState {}

final class BMISuccessState extends BmiState {
  final List<dynamic> bmiData;
  final bool isDialog;
  BMISuccessState({required this.bmiData, required this.isDialog});
}

final class BMIFailureState extends BmiState {}
