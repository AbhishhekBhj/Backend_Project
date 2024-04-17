part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ViewProfileClickedEvent extends ProfileEvent {}

class NavigateToViewProfileClickedEvent extends ProfileEvent {}

class EditProfileInformationClickedEvent extends ProfileEvent {

  final UserModel userModel;

  EditProfileInformationClickedEvent({required this.userModel});
}

class ChangePasswordClickedEvent extends ProfileEvent {
  final String newPassword;

  ChangePasswordClickedEvent(this.newPassword);
}

class CheckPasswordClickEvent extends ProfileEvent {
  final String password;

  CheckPasswordClickEvent(this.password);
}

class ProfileUploadProfilePictureEvent extends ProfileEvent {
  final File image;

  ProfileUploadProfilePictureEvent({required this.image});
}

class GetProfileInfoEvent extends ProfileEvent {}