import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wins_core_flutter/helpers/ToastEasy.dart';

import '../../firebase_options.dart';
import '../../generate/lib/api.dart';
import '../Auth/Services/AuthState.dart';

class FbPushService {
  bool isAndroid() {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }

  Future<void> OnRunApp() async {
    if (isAndroid()) {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
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

    var a = AuthState();
    await a.savePushToken(token ?? "");
  }


  void ShowPushPromise() async {

    var a = AuthState();

    var tokenHave =    await a.getPushToken();

    if(tokenHave!=null){
      return;
    }

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
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

        var a = AuthState();
        await a.savePushToken(token ?? "");

        print("PushNotificationApi send push");
        final api_instance = PushNotificationApi();
        await api_instance.notifyServicePushNotificationSetPushTokenPost(
          PushTokenUpdateRequest(
            sessionId: (await a.getSessionId()) ?? 0,
            token: token!,
          ),
        );

        ToastEasy.Info("Пуш уведомления подключены", Icons.import_contacts);
      }
    }

  }

}
