import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//android configuration

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('logo');

  @Summary("This method will be used to initalize the notfications to be sent")
  void initializeNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @Summary("use flutter local notfication to send notification to the user")
  void sendNotifications(String title, String body) async {
    //instance is required to send notifications in android
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channelId", "channelName",
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true);

//use the same instance of android notification details
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        1, title, body, notificationDetails);
  }

  @Summary(
      "use flutter local notfication to send notification to the user with some interval")
  void sendNotificationsWithInterval(String title, String body) async {
    //instance is required to send notifications in android
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channelId", "channelName",
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high);

//use the same instance of android notification details
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      10,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      notificationDetails,
      payload: "hi",
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void stopNotification() async {
    //cancels notification with that particular id
    _flutterLocalNotificationsPlugin.cancel(1);

    //cancels all notifications

    _flutterLocalNotificationsPlugin.cancelAll();
  }
}
