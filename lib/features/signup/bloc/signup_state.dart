part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

// indicates form is ready
abstract class SignupActionState extends SignupState{}
final class SignupInitial extends SignupState {}

//signup process in progress
class SignupLoadingState extends SignupState{}



//successful signup
class SignupSuccessState extends SignupActionState{}

//some error occured during signup
class SignupErrorState extends SignupState{}



class SignupNavigationState extends SignupActionState{}