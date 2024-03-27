import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/features/signup/ui/welcome_screen.dart/logins.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

import '../../../repo/profile repo/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ChangePasswordClickedEvent>(changePasswordClickedEvent);
    on<CheckPasswordClickEvent>(checkPasswordClickEvent);
    on<ProfileUploadProfilePictureEvent>(uploadProfilePictureEvent);
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

  FutureOr<void> uploadProfilePictureEvent(
      ProfileUploadProfilePictureEvent event,
      Emitter<ProfileState> emit) async {
    try {
      var response = await ProfileRepository.uploadProfilePicture(event.image);

      if (response.status == 200) {
        emit(ProfilePictureUploadSuccessState());
        Fluttertoast.showToast(msg: 'Profile Picture Uploaded Successfully');

        var profilePictureUrl = response.profilePictureUrl;
        UserDataManager.userData['profile_picture'] = profilePictureUrl;
      } else {
        emit(ProfilePictureUploadFailureState());
        Fluttertoast.showToast(msg: 'Profile Picture Upload Failed');
      }
    } catch (e) {
      emit(ProfilePictureUploadFailureState());
      log(e.toString());
      Fluttertoast.showToast(msg: 'Profile Picture Upload Failed');
    }
  }
}
