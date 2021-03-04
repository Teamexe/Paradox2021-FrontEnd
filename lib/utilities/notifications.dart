import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future onSelectNotification(String payload) async {
  Fluttertoast.showToast(
      msg: "Welcome To Paradox 2k21",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future showNotification(String title, String subtitle) async {
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('launcher_icons');
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);

  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    'your channel id',
    'Temple Shots',
    'your channel description',
    importance: Importance.Max,
    priority: Priority.High,
    color: Colors.red,
    enableLights: true,
    largeIcon: DrawableResourceAndroidBitmap("launcher_icons"),
    styleInformation: MediaStyleInformation(),
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  Future.delayed(
      Duration(seconds: 60),
      () async => {
            await flutterLocalNotificationsPlugin.show(
                1, title, subtitle, platformChannelSpecifics,
                payload: ""),
          });
  for (int i = 10; i <= 24; i += 6) {
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        i + 10,
        "Play Paradox and win cash prize",
        'Check out paradox app.',
        Time(i, 0, 0),
        platformChannelSpecifics,
        payload: "");
  }

  for (int i = 12; i <= 24; i += 6) {
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        i + 10,
        "Refer friends and increase your chances of winning.",
        'Check out paradox app.',
        Time(i-1, 0, 0),
        platformChannelSpecifics,
        payload: "");
  }
}
