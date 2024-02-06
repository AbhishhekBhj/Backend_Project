import 'dart:async';

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
        height: event.bodyMeasurement.height,
        weight: event.bodyMeasurement.weight,
        chestSize: event.bodyMeasurement.chestSize,
        waistSize: event.bodyMeasurement.waistSize,
        hipSize: event.bodyMeasurement.hipSize,
        leftArm: event.bodyMeasurement.leftArm,
        rightArm: event.bodyMeasurement.rightArm,
        leftQuadricep: event.bodyMeasurement.leftQuadricep,
        rightQuadricep: event.bodyMeasurement.rightQuadricep,
        leftCalf: event.bodyMeasurement.leftCalf,
        rightCalf: event.bodyMeasurement.rightCalf,
        leftForearm: event.bodyMeasurement.leftForearm,
        rightForearm: event.bodyMeasurement.rightForearm,
        notes: event.bodyMeasurement.notes);
    if (updateMeasurement) {
      Fluttertoast.showToast(msg: 'Measurement updated successfully');
      emit(MeasurementUpdateSuccessState());
    } else {
      Fluttertoast.showToast(msg: 'Failed to update measurement');
      emit(MeasurmentsUpdateFailureState());
    }
  }

  FutureOr<void> measurementsHistoryViewEvent(
      MeasurementsHistoryViewEvent event, Emitter<MeasurementsState> emit) {
   
  }
}
