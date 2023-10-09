part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileViewFailureState extends ProfileState {}

class NavigateEditPageState extends ProfileState {}

class ProfileEditInitialState extends ProfileState {}

class ProfileEditLoadingState extends ProfileState {}

class ProfileEditSuccessState extends ProfileState {}

class ProfileEditFailureState extends ProfileState {}
