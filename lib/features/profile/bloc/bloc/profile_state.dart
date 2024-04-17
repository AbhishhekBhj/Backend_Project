part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}




class ProfileEditLoadingState extends ProfileState {}

class ProfileEditSuccessState extends ProfileState {}

class ProfileEditFailureState extends ProfileState {}


class PasswordChangeLoadingState extends ProfileState {}
class PasswordChangeSuccessState extends ProfileState {}
class PasswordChangeFailureState extends ProfileState {}


class PasswordCheckLoadingState extends ProfileState {}
class PasswordCheckSuccessState extends ProfileState {}
class PasswordCheckFailureState extends ProfileState {}




class ProfilePictureUploadLoadingState extends ProfileState {}
class ProfilePictureUploadSuccessState extends ProfileState {}
class ProfilePictureUploadFailureState extends ProfileState {}



class ProfileInfoLoadingState extends ProfileState {}
class ProfileInfoSuccessState extends ProfileState {
  final Map<String,dynamic> profileModel;

  ProfileInfoSuccessState({required this.profileModel});
}

class ProfileInfoFailureState extends ProfileState {
  final String errorMessage;

  ProfileInfoFailureState({required this.errorMessage});
}