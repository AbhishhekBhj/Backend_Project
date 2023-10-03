part of 'bmi_bloc.dart';

@immutable
sealed class BmiEvent {}

class BMIInitialEvent extends BmiEvent {}

class CalculateBMIClickedEvent extends BmiEvent {
  final BMIModel bmiModel;

  CalculateBMIClickedEvent({required this.bmiModel});
  
}

class ClearBMITextFieldsClickedEvent extends BmiEvent {}
