import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/app_features.dart';
import 'package:mygymbuddy/data/models/home_features_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc._() : super(HomeInitial());
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitalEvent>(homeInitialEvent);
    on<OptionIconClickedEvent>(optionIconClickedEvent);
    on<StartWorkoutClickedEvent>(startWorkoutClickedEvent);
    on<DietTrackerClickedEvent>(dietTrackerClickedEvent);
    on<RemindersClickedEvent>(remindersClickedEvent);
    on<DrinkWaterClickedEvent>(drinkWaterClickedEvent);
    on<BmiClickedEvent>(bmiClickedEvent);
    on<MeasurementsClickedEvent>(measurementsClickedEvent);
  }
  static final HomeBloc _instance = HomeBloc._(); // static instance variable

  static HomeBloc get instance => _instance; //getter for instance

  FutureOr<void> optionIconClickedEvent(
      OptionIconClickedEvent event, Emitter<HomeState> emit) {
        emit(HomeInitial());
    emit(HomeClickSideBarOptionActionState());
  }

  FutureOr<void> startWorkoutClickedEvent(
      StartWorkoutClickedEvent event, Emitter<HomeState> emit) {
        emit(HomeInitial());
    emit(HomeNavigateToWorkoutPageActionState());
  }

  FutureOr<void> dietTrackerClickedEvent(
      DietTrackerClickedEvent event, Emitter<HomeState> emit) {
        emit(HomeInitial());
    // print('avc
    emit(HomeInitial());
    emit(HomeNavigateToCaloriesPageActionState());
  }

  FutureOr<void> remindersClickedEvent(
      RemindersClickedEvent event, Emitter<HomeState> emit) {
        emit(HomeInitial());
    emit(HomeNavigateToRemindersPageActionState());
  }

  FutureOr<void> drinkWaterClickedEvent(
      DrinkWaterClickedEvent event, Emitter<HomeState> emit) {
        emit(HomeInitial());
    emit(HomeNavigateToDrinkWaterPageActionState());
  }

  FutureOr<void> bmiClickedEvent(
      BmiClickedEvent event, Emitter<HomeState> emit) {
        emit(HomeInitial());
    emit(HomeNavigateToBmiPageActionState());
  }

  FutureOr<void> measurementsClickedEvent(
      MeasurementsClickedEvent event, Emitter<HomeState> emit) {
        emit(HomeInitial());
    emit(HomeNavigateToMeasurementsPageActionState());
  }

  FutureOr<void> homeInitialEvent(
      HomeInitalEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadedSuccessState(
      featuresModelList: Features.featuresList
          .map((feature) => FeatureModel(
                image: feature.image,
                title: feature.title,
                subtitle: feature.subTitle,
                onTap: feature.onTap,
              ))
          .toList(),
    ));
  }
}
