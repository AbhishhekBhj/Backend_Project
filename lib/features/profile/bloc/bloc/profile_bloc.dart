import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/features/signup/ui/welcome_screen.dart/logins.dart';

import '../../../repo/profile repo/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ChangePasswordClickedEvent>(changePasswordClickedEvent);
    on<CheckPasswordClickEvent>(checkPasswordClickEvent);
  }

  FutureOr<void> changePasswordClickedEvent(
      ChangePasswordClickedEvent event, Emitter<ProfileState> emit) async {
    emit(PasswordChangeLoadingState());

    ProfileRepository profileRepository = ProfileRepository();
    bool passwordChanged =
        await profileRepository.changePassword(event.newPassword);
    if (passwordChanged) {
      emit(PasswordChangeSuccessState());
      Fluttertoast.showToast(msg: 'Password Changed Successfully');
      Get.offAll(DemoLoginPage());
    } else {
      emit(PasswordChangeFailureState());
      Fluttertoast.showToast(msg: 'Password Change Failed');
    }
  }

  FutureOr<void> checkPasswordClickEvent(
      CheckPasswordClickEvent event, Emitter<ProfileState> emit) async {
    emit(PasswordCheckLoadingState());
    ProfileRepository profileRepository = ProfileRepository();

    bool validPassword = await profileRepository.checkPassword(event.password);
    if (validPassword) {
      emit(PasswordCheckSuccessState());
      log('success state reached');
      Fluttertoast.showToast(msg: 'Correct Password');
    } else {
      emit(PasswordCheckFailureState());
      Fluttertoast.showToast(msg: 'Password is incorrect');
    }
  }
}
