import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackGroundMessaging(RemoteMessage message) async {
  log("Function: handleBackGroundMessaging");
  try {
    log('Handling a background message ${message.messageId}');
  } catch (e) {
    log('Error: $e');
  }
}

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();

    log('Token fo fcm: $token'); //remove in production

    // FirebaseMessaging.onBackgroundMessage(handleBackGroundMessaging);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification title: ${message.notification?.title}');
        log("Message also contained a notification body: ${message.notification?.body}");
        log("Message also contained a notification body: ${message.notification?.bodyLocKey}");
      }
    });
  }
}
