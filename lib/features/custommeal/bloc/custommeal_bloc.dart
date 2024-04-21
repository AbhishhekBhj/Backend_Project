import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/custom_meal_model.dart';
import '../../repo/custommeal_repo/custom_meal_repo.dart';

part 'custommeal_event.dart';
part 'custommeal_state.dart';

class CustommealBloc extends Bloc<CustommealEvent, CustommealState> {
  CustommealBloc() : super(CustommealInitial()) {
    on<GetMyCustomMeal>((event, emit) async {
      emit(CustommealLoading());
      var customMeal = await CustomMealRepository.getmyCustomMeal();
      if (customMeal != null) {
        emit(CustommealLoaded(customMeal));
      } else {
        emit(CustommealError('Failed to load custom meal'));
      }
    });
  }
}
