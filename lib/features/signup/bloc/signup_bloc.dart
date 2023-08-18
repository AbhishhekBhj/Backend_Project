
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/signup_model.dart';


part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {
      if (event is SignupFormSubmittedEvent) {
        signupFormSubmittedEvent();
      } else if (event is RedirectLoginPageClickedEvent) {
        emit(SignupNavigationState());
      } else if (event is SignupFormUpdatedEvent) {
        signupFormUpdatedEvent();
      }
    });
  }

  Future<void> signupFormSubmittedEvent() async {
    // TODO: handle form submisson, then transition to signup loading state which connects to backend, process the request, transtion to SignupSuccessState or SignupErrorState
    emit(SignupLoadingState());

    try {
      //api call to submit data
      final isSuccess = await _callApiToSubmitSignupForm();
      if (isSuccess) {
        emit(SignupSuccessState());
      } else {
        emit(SignupErrorState());
      }
    } catch (e) {
      // TODO: handle api call exceptions
      emit(SignupErrorState());
    }
  }

  void redirectLoginPageClickedEvent() {
    // TODO: redirect the user to the login page
    // Navigator.push(context,MaterialPageRoute(builder: (context)=> const Login()));
  }

  void signupFormUpdatedEvent() {
    // TODO : handle form field updates and transition to signupformupdatedstate
  }
}

Future<bool> _callApiToSubmitSignupForm() async {
  // TODO: Implement APi call and return true for sucess and false for error

  return false;
}
