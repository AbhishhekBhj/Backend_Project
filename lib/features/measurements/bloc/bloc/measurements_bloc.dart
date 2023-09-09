import 'dart:async';

import 'package:bloc/bloc.dart';
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
      bodyWeight: event.measurementModel.bodyweight,
      leftArm: event.measurementModel.leftArm,
      rightArm: event.measurementModel.rightArm,
      chest: event.measurementModel.chest,
      leftQuadriceps: event.measurementModel.leftQuadricep,
      rightQuadriceps: event.measurementModel.rightQuadricep,
      leftCalve: event.measurementModel.leftCalve,
      rightCalve: event.measurementModel.rightCalve,
      leftForearm: event.measurementModel.leftForearm,
      rightForearm: event.measurementModel.rightForearm,
      waist: event.measurementModel.waist,
    );
    if (updateMeasurement) {
      emit(MeasurementUpdateSuccessState());
    } else {
      emit(MeasurmentsUpdateFailureState());
    }
  }

  FutureOr<void> measurementsHistoryViewEvent(
      MeasurementsHistoryViewEvent event, Emitter<MeasurementsState> emit) {
    // Handle history view event...
  }
}
