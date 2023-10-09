part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ViewProfileClickedEvent extends ProfileEvent {}

class NavigateToViewProfileClickedEvent extends ProfileEvent {}

class EditProfileInformationClickedEvent extends ProfileEvent {}
