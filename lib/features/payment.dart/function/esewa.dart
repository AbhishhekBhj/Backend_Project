import 'dart:convert';

import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/payment.dart/bloc/bloc/payment_bloc.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_flutter_sdk/payment_failure.dart';
import 'dart:developer';
import "package:http/http.dart" as http;

class ESEWA {
  PaymentBloc paymentBloc = PaymentBloc();

  pay(dynamic type) {
    try {
      EsewaFlutterSdk.initPayment(
          esewaConfig: EsewaConfig(
              clientId: CLIENT_ID,
              secretId: SECRET_KEY,
              environment: Environment.test),
          esewaPayment: EsewaPayment(
              productId: "ABhishek",
              productName: "Abhishek",
              productPrice: "100"),
          onPaymentSuccess: (EsewaPaymentSuccessResult result) {
            log(":::SUCCESS::: => $result");

            var message = result.toJson();
            var mes = message['message'];

            if (mes != null) {
              paymentBloc
                  .add(MakeMeProMemberEvent(subscriptionType: type.toString()));
            }
          },
          onPaymentFailure: (EsewaPaymentFailure failure) {
            debugPrint("Failure");
          },
          onPaymentCancellation: (data) {
            debugPrint("Cancel");
          });
    } catch (e) {
      print(e);
    } finally {
      print("Payment done");
    }
  }

  callVerify(result) async {
    print(result);
    var response = await http.get(
        Uri.parse("https://esewa.com.np/mobile/transaction?txnRefId=$result"),
        headers: {
          "Content-Type": "application/json",
          "merchantSecret": SECRET_KEY,
          "merchantID": CLIENT_ID
        });
    log(response.body);

    return response;
  }

  verify(EsewaPaymentSuccessResult result, dynamic type) async {
    print("Verifying payment");
    print(result);
    Map data = result.toJson();
    var response = await callVerify(data['refId']);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Payment Successful");
      MakeMeProMemberEvent(subscriptionType: type.toString());
    } else {
      Fluttertoast.showToast(msg: "Payment Failed");
    }

    log(jsonDecode(response.body).toString());
    log(data.toString());

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Payment Successful");
    } else {
      Fluttertoast.showToast(msg: "Payment Failed");
    }
  }
}
