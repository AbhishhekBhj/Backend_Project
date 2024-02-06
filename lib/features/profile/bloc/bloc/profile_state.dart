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

