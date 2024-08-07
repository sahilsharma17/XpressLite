import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



import '../localStorage/preference_handler.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print(
      'Handling a background message ${message.messageId} and message is: ${message.data}');
}

_msgHandler(RemoteMessage? message) {

  print("Notification Navigator method"); /// add for the testing by H
  // if (message != null) {
  //   print('A new onMessageOpenedApp event was published! ${message}');
  //   // print("title ${message.notification?.title??""}");
  //   if (message.data["payload"] == "Overdue Tasks") {
  //     print("OverDueAssignedTaskScreen");
  //     navigatorKey.currentState
  //         ?.push(MaterialPageRoute(builder: (context) => OverdueTaskScreen()));
  //   } else if (message.data["payload"] == "Tasks ready to start tomorrow") {
  //     print("openNewAssignedTaskScreen");
  //     navigatorKey.currentState?.push(MaterialPageRoute(
  //         builder: (context) => MyTaskScreen(
  //           pausedListShow: false,
  //         )));
  //   } else if (message.data["payload"] == "New Tasks Today") {
  //     print("openNewAssignedTaskScreen");
  //     navigatorKey.currentState?.push(
  //         MaterialPageRoute(builder: (context) => NewTaskAssignedScreen()));
  //   }
  // } else {
  //   print("getting null value in message");
  //   // MethodUtils.toast(navigatorKey.currentContext!, "getting null value in message");
  // }
}

Future<void> initFirebase() async {
  try {

    await Firebase.initializeApp();

    if (Platform.isIOS) {
      getIosToken();
    }else{
      getAndroidToken();
    }

    //setting up platform specific local notification package implementation.
    await _platformSpecificLocalNotification();

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // FirebaseMessaging.instance.getInitialMessage().then(_msgHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(_msgHandler);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  } catch (e) {
    debugPrint("Error Occurred while initializing FIREBASE:: $e");
  }
}

Future<void> _platformSpecificLocalNotification() async {

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  if (Platform.isIOS)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
}

void getIosToken() {
  if (Platform.isIOS) {

    FirebaseMessaging.instance.getAPNSToken().then((apnToken) async {
      if (apnToken != null) {
        await PreferenceHandler.setFCMToken(apnToken);

      }
      debugPrint("APN TOKEN FOUND: $apnToken");
    });
  }
}

void getAndroidToken() {
  FirebaseMessaging.instance
      .requestPermission(sound: true, badge: true, alert: true);
  FirebaseMessaging.instance.getToken().then((value) async {
    if (value != null) {
      await PreferenceHandler.setFCMToken(value);
      debugPrint("FCM TOKEN $value");
    }
  });
}

//--------------------- Firebase Messaging configurations ----------------------

//
// initialize the Notification channel for android, this will help in receiving notification
// this is going to be a top-level initialization(i.e. global)

//MUST BE TOP-LEVEL
AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.high,
);

//initialize our flutter local notifications plugin, this is also a top level initialization
//MUST BE TOP-LEVEL
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


//***** Setting listeners for firebase and flutter local notification initialization - context is needed. *******************
Future<void> setupFCMListeners() async {
  await initFirebase();
  //--------Initializing Flutter local notification for Android-----------------
  var initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/launcher_icon');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("MESSAGE RECEIVED IN FG: ${message.notification!.title!}");
    _buildNotificationPopUp(message);
  });

  final setting =
  InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(setting,
      onDidReceiveNotificationResponse: (v) {
        var msg = RemoteMessage.fromMap(jsonDecode(v.payload!));
        _msgHandler(msg);


      }, onDidReceiveBackgroundNotificationResponse: (v) {
        var msg = RemoteMessage.fromMap(jsonDecode(v.payload!));
        _msgHandler(msg);

      });
}

void _buildNotificationPopUp(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    print("Notification Condition Passed ");

    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            playSound: true,
            icon: "@mipmap/launcher_icon",
          ),
        ),
        payload: jsonEncode(message.toMap())
    );
  } else {
    print("Notification Condition Failed ");
  }
}
