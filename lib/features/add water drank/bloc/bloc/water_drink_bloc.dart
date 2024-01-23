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
  }

  FutureOr<void> waterDrinkLogEvent(
      WaterDrinkLogEvent event, Emitter<WaterDrinkState> emit) async {
    emit(WaterDrinkLogLoading());

    bool waterLogSuccess = await LogWaterRepository.logWaterConsumed(
      username: event.waterLog.username,
      volume: event.waterLog.volume,
    );

    if (waterLogSuccess) {
      emit(WaterDrinkLogSuccessState());
      Fluttertoast.showToast(msg: "Water logged successfully");
    } else {
      emit(WaterDrinkLogFailureState());
      Fluttertoast.showToast(msg: "Water logged failed");

    }
  }
}
