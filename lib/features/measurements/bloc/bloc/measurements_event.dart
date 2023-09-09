// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'measurements_bloc.dart';

@immutable
sealed class MeasurementsEvent {}

class MeasurementsInitialEvent extends MeasurementsEvent {}

class MeasurementsUpdateClickedEvent extends MeasurementsEvent {
  final Measurement measurementModel;
  MeasurementsUpdateClickedEvent({
    required this.measurementModel,
  });
}

class MeasurementsHistoryViewEvent extends MeasurementsEvent {}
