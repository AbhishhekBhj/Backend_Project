import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/log_water_model.dart';
import 'package:mygymbuddy/features/repo/log%20water%20repo/log_water_repository.dart';

part 'water_drink_event.dart';
part 'water_drink_state.dart';

class WaterDrinkBloc extends Bloc<WaterDrinkEvent, WaterDrinkState> {
  WaterDrinkBloc() : super(WaterDrinkInitial()) {
    on<WaterDrinkLogEvent>(waterDrinkLogEvent);
    on<WaterDrinkHistoryEvent>(waterDrinkHistoryEvent);
    on<WaterDrinkLogDeleteEvent>(waterDrinkLogDeleteEvent);
  }

  FutureOr<void> waterDrinkLogEvent(
      WaterDrinkLogEvent event, Emitter<WaterDrinkState> emit) async {
    emit(WaterDrinkLogLoading());

    bool waterLogSuccess =
        await LogWaterRepository.logWaterConsumed(waterLog: event.waterLog!);

    if (waterLogSuccess) {
      emit(WaterDrinkLogSuccessState());
      Fluttertoast.showToast(msg: "Water logged successfully");
    } else {
      emit(WaterDrinkLogFailureState());
      Fluttertoast.showToast(msg: "Water logged failed");
    }
  }

  FutureOr<void> waterDrinkHistoryEvent(
      WaterDrinkHistoryEvent event, Emitter<WaterDrinkState> emit) async {
    emit(WaterDrinkHistoryLoading());
    List<dynamic> waterLogs =
        await GetWaterHistoryDataRepository.getWaterHistoryData();

    if (waterLogs.isNotEmpty) {
      emit(WaterDrinkHistorySuccessState(waterLogs: waterLogs));
    } else {
      emit(WaterDrinkHistoryFailureState());
    }
  }

  FutureOr<void> waterDrinkLogDeleteEvent(
      WaterDrinkLogDeleteEvent event, Emitter<WaterDrinkState> emit) async {
    emit(WaterDrinkLogDeleteLoading());

    bool deleteSuccess = await DeleteWaterIntakeRepository.deleteWaterIntake(
        intakeID: event.intakeID);

    if (deleteSuccess) {
      emit(WaterDrinkLogDeleteSuccessState());
      Fluttertoast.showToast(msg: "Water log deleted successfully");
    } else {
      emit(WaterDrinkLogDeleteFailureState());
      Fluttertoast.showToast(msg: "Water log deletion failed");
    }
  }
}
