part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitalEvent extends HomeEvent {}



class HomePageFetchRequiredDataEvent extends HomeEvent{}
