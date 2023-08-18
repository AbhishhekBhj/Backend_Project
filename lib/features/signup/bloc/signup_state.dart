part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

// indicates form is ready
final class SignupInitial extends SignupState {}

//signup process in progress
class SignupLoadingState extends SignupState{}

//successful signup
class SignupSuccessState extends SignupState{}

//some error occured during signup
class SignupErrorState extends SignupState{}

//form has been updated
class SignupFormUpdated extends SignupState{}

class SignupNavigationState extends SignupState{}