import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/features/home/ui/common_ui.dart';

import '../../../repo/payment repo/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<MakeMeProMemberEvent>(makeMeProMemberEvent);
  }

  FutureOr<void> makeMeProMemberEvent(
      MakeMeProMemberEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());

    Map<String, dynamic> result =
        await MakeMeProMemberRepository.makeMeProMember(event.subscriptionType);

    log(result.toString());

    if (result['status'] == 200) {
      emit(PaymentSuccess(message: result['message']));
      Get.to(BaseClass());
    } else {
      emit(PaymentFailure(errorMessage: result['message']));
      Fluttertoast.showToast(msg: 'Payment Failed');
    }
  }
}
