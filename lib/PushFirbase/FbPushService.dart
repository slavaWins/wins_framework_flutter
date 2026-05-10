import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class FbPushService {

  static ValueChanged<String>?  OnTakePushToken;
  static bool  IsHavePushToken=false;


  bool isAndroid() {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }

  Future<void> OnRunApp(FirebaseOptions currentPlatform) async {
    if (isAndroid()) {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: currentPlatform,
        );
      }

      await InitMsgService();
    }
  }

  Future<void> InitMsgService() async {
    print("1XXX InitMsgService:");
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    var token = await messaging.getToken();
    print("-------push TOKEN:");
    print(token);

    if(OnTakePushToken!=null) {
      OnTakePushToken!(token ?? "");
    }

  }


  void ShowPushPromise(FirebaseOptions currentPlatform) async {


    if(IsHavePushToken){
      return;
    }

    await Firebase.initializeApp(
      options: currentPlatform,
    );


    await Future.delayed(Duration(seconds: 1));

    final notificationSettings = await FirebaseMessaging.instance
        .requestPermission(provisional: true);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );


    if( defaultTargetPlatform == TargetPlatform.iOS) {
      print('get getAPNSToken');
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken == null) {
        await Future.delayed(Duration(seconds: 1));

        print('get getAPNSToken 2');
        String? tokengetAPNSToken = await messaging.getAPNSToken();
      }
      await Future.delayed(Duration(seconds: 1));
    }


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {

      print('User granted permission');
      String? token = await messaging.getToken();
      print("FCM Token: $token");

      if (token != null) {
        print('send token');


        if(OnTakePushToken!=null) {
          OnTakePushToken!(token);
        }


      }
    }

  }

}
