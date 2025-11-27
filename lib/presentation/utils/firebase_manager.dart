import 'dart:async';
import 'package:moloch_app/presentation/utils/local_notification_manager.dart';
import 'package:moloch_app/presentation/utils/notification_payload_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseManager {
  final notificationManager = NotificationManager();
  StreamSubscription<RemoteMessage>? onMessageSubscription;
  StreamSubscription<RemoteMessage>? onMessageOpenedAppSubscription;

  void onListerners(BuildContext context) {
    notificationManager.initializeNotifications(context);
    onMessageSubscription = FirebaseMessaging.onMessage.listen(
      _handleForegroundMessage,
    );
    onMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp
        .listen(_handleMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void closed() {
    onMessageSubscription?.cancel();
    onMessageOpenedAppSubscription?.cancel();
  }

  static Future<void> requestPermissionNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<String?> getToken() async {
    await removeToken();

    return FirebaseMessaging.instance.getToken();
  }

  static Future<void> subscribeToAllTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic('all');
  }

  static Future<void> removeToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (_) {}
  }

  void onTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {})
        .onError((_) {});
  }

  /// Este evento se dispara cuando se toca una notificación y la aplicación está abierta.
  void _handleMessageOpenedApp(RemoteMessage message) {}

  /// Aquí puedes manejar la notificación recibida mientras la aplicación está en primer plano.
  void _handleForegroundMessage(RemoteMessage message) {
    try {
      PayloadNotificationManager.init(message);
      notificationManager.showNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
      );
    } catch (_) {
    }
  }
}

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {}
