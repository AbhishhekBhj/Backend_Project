import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/food_item.dart';
import 'package:mygymbuddy/features/repo/food%20repo/food_repository.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<CreateCustomFoodClickedEvent>(createCustomFoodClickedEvent);
  }

  FutureOr<void> createCustomFoodClickedEvent(
      CreateCustomFoodClickedEvent event, Emitter<FoodState> emit) async {
    emit(FoodUploadLoading());
    try {
      bool list =
          await CustomFoodRepository.createCustomFoodItem(event.foodItem);

      if (list) {
        emit(FoodUploadSuccess());
        Fluttertoast.showToast(
            msg: 'Food item created successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        emit(FoodUploadFailure(
            errorMessage: 'An error occurred. Please try again later.'));
      }
    } catch (e) {
      emit(FoodUploadFailure(
          errorMessage: 'An error occurred. Please try again later.'));
    }
  }
}
