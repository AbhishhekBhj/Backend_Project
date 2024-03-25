part of 'measurements_bloc.dart';

@immutable
sealed class MeasurementsState {}

final class MeasurementsInitial extends MeasurementsState {}

final class MeasurementsActionState extends MeasurementsState {}

final class MeasurementsOptionLoadingState extends MeasurementsState {}

final class MeasurementUpdateLoadingState extends MeasurementsState {}

final class MeasurementUpdateSuccessState extends MeasurementsState {
  
}

final class MeasurmentsUpdateFailureState extends MeasurementsState {}



final class MeasurementHistoryViewSuccessState extends MeasurementsState {
  final List<BodyMeasurement> measurements;

  MeasurementHistoryViewSuccessState({
    required this.measurements,
  });
}

final class MeasurementHistoryViewLoadingState extends MeasurementsState {}

final class MeasurementHistoryViewFailureState extends MeasurementsState {}
