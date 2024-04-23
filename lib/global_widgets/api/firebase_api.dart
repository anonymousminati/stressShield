import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stress_sheild/main.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize Firebase Cloud Messaging
  Future<void> initNotification() async {
    try {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );
      final FCMToken = await _firebaseMessaging.getToken();
      print('Token: ${FCMToken.toString()}');
      initPushNotification();
    } catch (e) {
      print('Error initializing Firebase Cloud Messaging: $e');
    }
  }

  // Handle incoming messages
  void handleMessages(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState!.pushNamed('notification', arguments: message);
  }

  // Initialize push notification listeners
  Future<void> initPushNotification() async {
    try {
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        handleMessages(message);
      });
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
    } catch (e) {
      print('Error initializing push notification listeners: $e');
    }
  }
}
