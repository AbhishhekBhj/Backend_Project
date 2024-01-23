import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/food_model.dart';
import 'package:mygymbuddy/data/models/calorie_logging_model.dart';

import 'package:mygymbuddy/features/repo/calories%20repo/calories_repository.dart';
part 'calories_event.dart';
part 'calories_state.dart';

class CaloriesBloc extends Bloc<CaloriesEvent, CaloriesState> {
  CaloriesBloc() : super(CaloriesInitial()) {
    on<CaloriesInitalEvent>(caloriesInitalEvent);
    on<CaloriesSearchByNameEvent>(caloriesSearchByNameEvent);
    on<CaloriesConsumedLogEvent>(caloriesConsumedLogEvent);
  }

  void caloriesInitalEvent(
      CaloriesInitalEvent event, Emitter<CaloriesState> emit) async {
    emit(CaloriesLoadingState());
  }

  Future<void> fetchInitialData(Emitter<CaloriesState> emit) async {}

  void caloriesSearchByNameEvent(
      CaloriesSearchByNameEvent event, Emitter<CaloriesState> emit) async {
    final List<FoodModel> foodData =
        await MultiCaloriesRepository.getCaloricInformation(
            foodName: event.foodModel.name);
    emit(CaloriesFetchingState());

    if (foodData.isNotEmpty) {
      await Future.delayed(
          Duration(milliseconds: 500)); // Wait for a short delay
      emit(CaloriesFoundSuccessState(foodModel: foodData));
    } else {
      emit(CaloriesFoundErrorState());
    }
  }

  FutureOr<void> caloriesConsumedLogEvent(
      CaloriesConsumedLogEvent event, Emitter<CaloriesState> emit) async {
    emit(CaloriesLoggingLoadingState());
    bool caloriesLoggingSuccess = await CaloriesLogRepository.logCalories(
        username: event.caloriesLog.username,
        food: event.caloriesLog.food,
        servingSizeConsumed: event.caloriesLog.servingSizeConsumed,
        proteinConsumed: event.caloriesLog.proteinConsumed,
        carbsConsumed: event.caloriesLog.carbsConsumed,
        fatConsumed: event.caloriesLog.fatConsumed,
        caloriesConsumed: event.caloriesLog.caloriesConsumed);

    if (caloriesLoggingSuccess) {
      emit(CaloriesLoggingSuccessState());
      Fluttertoast.showToast(
          msg: "Calories logged successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      emit(CaloriesLoggingErrorState());
      Fluttertoast.showToast(
          msg: "Error logging calories",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    // Handle the result as needed
  }
}
