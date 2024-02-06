import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/app_features.dart';
import 'package:mygymbuddy/data/models/home_features_model.dart';
import 'package:mygymbuddy/data/models/home_model.dart';
import 'package:mygymbuddy/features/repo/home%20repo/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc._() : super(HomeInitial());
  HomeBloc() : super(HomeInitial()) {
    on<HomePageFetchRequiredDataEvent>(homePageFetchRequiredDataEvent);
  }

  FutureOr<void> homePageFetchRequiredDataEvent(
      HomePageFetchRequiredDataEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomePageFetchDataLoadingState());
      HomeRepository homeRepository = HomeRepository();

      final fetchedData = await homeRepository.getHomePageData();

      log('Fetched Data: $fetchedData');

      emit(HomePageFetchDataSuccessState(fetchedData));
    } catch (error) {
      log('Error: $error');
      emit(HomePageFetchDataFailureState());
    }
  }
}
