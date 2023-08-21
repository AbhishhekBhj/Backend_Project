// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {
  // Represents the initial state of the home page.
}

class HomeLoadingState extends HomeState {
  // Represents the state when the home page is in a loading state.
}

class HomeLoadedSuccessState extends HomeState {
  // Represents the state when the home page content has been successfully loaded.
  final List<Features> featuresList;
  HomeLoadedSuccessState({
    required this.featuresList,
  });
}

class HomeErrorState extends HomeState {
  // Represents the state when an error occurs on the home page.
}

class HomeNavigateToWorkoutPageActionState extends HomeState {
  // Represents the state when the home page needs to navigate to the workout page.
}

class HomeNavigateToCaloriesPageActionState extends HomeState {
  // Represents the state when the home page needs to navigate to the calories page.
}

class HomeNavigateToBmiPageActionState extends HomeState {
  // Represents the state when the home page needs to navigate to the BMI page.
}

class HomeNavigateToRemindersPageActionState extends HomeState {
  // Represents the state when the home page needs to navigate to the reminders page.
}

class HomeNavigateToMeasurementsPageActionState extends HomeState {
  // Represents the state when the home page needs to navigate to the measurements page.
}

class HomeNavigateToDrinkWaterPageActionState extends HomeState {
  // Represents the state when the home page needs to navigate to the drink water page.
}

class HomeClickSideBarOptionActionState extends HomeState {
  // Represents the state when a sidebar option has been clicked.
}
