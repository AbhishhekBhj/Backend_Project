import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/measurement_model.dart';
import 'package:mygymbuddy/features/repo/measurments%20repo/measurements_repository.dart';

part 'measurements_event.dart';
part 'measurements_state.dart';

class MeasurementsBloc extends Bloc<MeasurementsEvent, MeasurementsState> {
  MeasurementsBloc() : super(MeasurementsInitial()) {
    on<MeasurementsInitialEvent>(measurementsInitialEvent);
    on<MeasurementsUpdateClickedEvent>(measurementsUpdateClickedEvent);
    on<MeasurementsHistoryViewEvent>(measurementsHistoryViewEvent);
  }

  FutureOr<void> measurementsInitialEvent(
      MeasurementsInitialEvent event, Emitter<MeasurementsState> emit) {
    emit(MeasurementsInitial());
  }

  FutureOr<void> measurementsUpdateClickedEvent(
      MeasurementsUpdateClickedEvent event,
      Emitter<MeasurementsState> emit) async {
    emit(MeasurementUpdateLoadingState());
    bool updateMeasurement = await MeasurementsRepository.updateMeasurements(
        bodyMeasurement: event.bodyMeasurement);
    if (updateMeasurement) {
      Fluttertoast.showToast(msg: 'Measurement updated successfully');
      emit(MeasurementUpdateSuccessState());
    } else {
      Fluttertoast.showToast(msg: 'Failed to update measurement');
      emit(MeasurmentsUpdateFailureState());
    }
  }

  FutureOr<void> measurementsHistoryViewEvent(
      MeasurementsHistoryViewEvent event,
      Emitter<MeasurementsState> emit) async {
    emit(MeasurementHistoryViewLoadingState());
    try {
      List<BodyMeasurement> measurements =
          await MeasurementDataGetRepository.getMeasurements();
      if (measurements.isNotEmpty) {
        emit(MeasurementHistoryViewSuccessState(measurements: measurements));
      } else {
        log('No measurements found');
        emit(MeasurementHistoryViewFailureState());
      }
    } catch (e) {
      log('Error fetching measurements: $e');
      emit(MeasurementHistoryViewFailureState());
    }
  }
}
