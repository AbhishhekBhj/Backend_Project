import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/food_model.dart';

part 'calories_event.dart';
part 'calories_state.dart';

class CaloriesBloc extends Bloc<CaloriesEvent, CaloriesState> {
  CaloriesBloc() : super(CaloriesInitial()) {
    on<CaloriesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
