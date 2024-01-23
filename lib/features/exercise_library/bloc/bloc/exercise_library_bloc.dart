import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/exercise_gallery.dart';
import 'package:mygymbuddy/features/repo/exercise%20gallery%20repo/exercise_gallery_repository.dart';

part 'exercise_library_event.dart';
part 'exercise_library_state.dart';

class ExerciseLibraryBloc
    extends Bloc<ExerciseLibraryEvent, ExerciseLibraryState> {
  ExerciseLibraryBloc() : super(ExerciseLibraryInitial()) {
    on<ExerciseGalleryFetchEvent>(exerciseGalleryFetchEvent);
  }

  FutureOr<void> exerciseGalleryFetchEvent(ExerciseGalleryFetchEvent event,
      Emitter<ExerciseLibraryState> emit) async {
    emit(ExerciseLibraryLoading());

    try {
      final List<ExerciseModel> exerciseGallery =
          await ExerciseGalleryRepository.getExerciseGallery();
      emit(ExerciseLibraryLoaded(exerciseGallery: exerciseGallery));
    } catch (e) {
      emit(ExerciseLibraryError());
      Fluttertoast.showToast(
          msg: "Error fetching exercise gallery",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: CupertinoColors.systemRed,
          textColor: CupertinoColors.white,
          fontSize: 16.0);
    }
  }
}
