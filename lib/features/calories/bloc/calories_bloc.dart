import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/food_model.dart';
import 'package:mygymbuddy/features/repo/calories%20repo/calories_repository.dart';
part 'calories_event.dart';
part 'calories_state.dart';

class CaloriesBloc extends Bloc<CaloriesEvent, CaloriesState> {
  CaloriesBloc() : super(CaloriesInitial()) {
    on<CaloriesInitalEvent>(caloriesInitalEvent);
    on<CaloriesSearchByNameEvent>(caloriesSearchByNameEvent);
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
}
