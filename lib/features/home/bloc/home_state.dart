// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  // final int tabIndex;
  // HomeState(this.tabIndex);
}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {
  // Represents the initial state of the home page.
}

class HomePageFetchDataLoadingState extends HomeActionState {
  // Represents the state when the home page is fetching data.
}

class HomePageFetchDataSuccessState extends HomeActionState {
  final HomeModel homeModel;
  HomePageFetchDataSuccessState(this.homeModel);
}

class HomePageFetchDataFailureState extends HomeActionState {
  
}
