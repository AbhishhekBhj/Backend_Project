import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/bmi_model.dart';
import 'package:mygymbuddy/features/bmi/ui/bmi_calculate_function.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc() : super(BmiInitial()) {
    on<BMIInitialEvent>(bmiInitialEvent);
    on<CalculateBMIClickedEvent>(calculateBMIEvent);
    on<ClearBMITextFieldsClickedEvent>(calculateBMITextFieldsClickedEvent);
  }

  FutureOr<void> bmiInitialEvent(
      BMIInitialEvent event, Emitter<BmiState> emit) {
    emit(BmiInitial());
  }

  FutureOr<void> calculateBMIEvent(
      CalculateBMIClickedEvent event, Emitter<BmiState> emit) {
    emit(BMILoadingState());

    List<dynamic> bmi = BMICalculations.calculateBMI(
        event.bmiModel.weightInKg, event.bmiModel.heightInMetre);

    emit(BMISuccessState(bmiData: bmi, isDialog: true));

    // showDialog(
    //     context: Get.context!,
    //     builder: ((context) {
    //       return AlertDialog(
    //         scrollable: true,
    //         title: Text('hi'),
    //       );
    //     }));
  }

  FutureOr<void> calculateBMITextFieldsClickedEvent(
      ClearBMITextFieldsClickedEvent event, Emitter<BmiState> emit) {
    emit(BmiInitial());
  }
}
