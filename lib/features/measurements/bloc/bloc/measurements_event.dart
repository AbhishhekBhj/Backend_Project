// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'measurements_bloc.dart';

@immutable
sealed class MeasurementsEvent {}

class MeasurementsInitialEvent extends MeasurementsEvent {}

class MeasurementsUpdateClickedEvent extends MeasurementsEvent {
  final BodyMeasurement bodyMeasurement;
  MeasurementsUpdateClickedEvent({
    required this.bodyMeasurement,
  });
}

class MeasurementsHistoryViewEvent extends MeasurementsEvent {}
