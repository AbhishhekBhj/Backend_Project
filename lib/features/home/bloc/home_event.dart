part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitalEvent extends HomeEvent {}

//event where the option icon is tapped
class OptionIconClickedEvent extends HomeEvent {}

//event where start workout option tapped
class StartWorkoutClickedEvent extends HomeEvent {}

// diet takcker option tapped
class DietTrackerClickedEvent extends HomeEvent {}

//reminders option tapped
class RemindersClickedEvent extends HomeEvent {}

//drink water option tapped
class DrinkWaterClickedEvent extends HomeEvent {}

//bmi option tapped
class BmiClickedEvent extends HomeEvent {}

//measurements option tapped
class MeasurementsClickedEvent extends HomeEvent {}

class MeditateClickedEvent extends HomeEvent{}

class ExerciseGalleryClickedEvent extends HomeEvent{}

class TabChange extends HomeEvent {
  final int tabIndex;
  TabChange({required this.tabIndex});
}
