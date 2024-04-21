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
    on<CaloriesLogDeleteEvent>(caloriesLogDeleteEvent);
    on<CaloriesIntakeRequestEvent>(caloriesIntakeRequestEvent);
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
            foodName: event.foodname!);
    emit(CaloriesFetchingState());

    if (foodData.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(CaloriesFoundSuccessState(foodModel: foodData));
    } else {
      emit(CaloriesFoundErrorState());
    }
  }

  FutureOr<void> caloriesConsumedLogEvent(
      CaloriesConsumedLogEvent event, Emitter<CaloriesState> emit) async {
    try {
      emit(CaloriesLoggingLoadingState());
      bool caloriesLoggingSuccess = await CaloriesLogRepository.logCalories(
        caloriesLog: event.caloriesLog!,
      );

      if (caloriesLoggingSuccess) {
        emit(CaloriesLoggingSuccessState());
        Fluttertoast.showToast(
          msg: "Calories logged successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        emit(CaloriesLoggingErrorState());
      }
    } catch (error) {
      // Handle the error here
      emit(CaloriesLoggingErrorState());

      Fluttertoast.showToast(
        msg: "Error logging calories: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  FutureOr<void> caloriesLogDeleteEvent(
      CaloriesLogDeleteEvent event, Emitter<CaloriesState> emit) async {
    emit(CaloriesLogDeleteLoadingState());
    bool caloriesLoggingSuccess =
        await DeleteCaloriesRepository.deleteCalories(caloriesId: event.id!);

    if (caloriesLoggingSuccess) {
      emit(CaloriesLogDeleteSuccessState());
      Fluttertoast.showToast(
          msg: "Calories log deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      emit(CaloriesLogDeleteErrorState());
      Fluttertoast.showToast(
          msg: "Error deleting calories log",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  FutureOr<void> caloriesIntakeRequestEvent(
      CaloriesIntakeRequestEvent event, Emitter<CaloriesState> emit) async {
    emit(CaloriesIntakeRequestLoadingState());
    List<dynamic> caloricIntakeData =
        await GetMyCaloricIntakeRepository.getMyCaloricIntake();

    if (caloricIntakeData.isNotEmpty) {
      emit(CaloriesIntakeRequestSuccessState(
          caloricIntakeList: caloricIntakeData));
    } else {
      emit(CaloriesIntakeRequestErrorState());
    }
  }
}
