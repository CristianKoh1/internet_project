import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';

class NotificationManager {
  static const String channelId = 'afinclic';
  static const String channelName = 'Alertas afinclic';
  static const String channelDescription =
      'Recibe notificaciones importantes sobre tu cuenta';
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications(BuildContext context) async {
    final InitializationSettings initializationSettings = _settings(context);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) async {
        await onDidReceiveNotificationResponse(context, notificationResponse);
      },
    );
  }

  InitializationSettings _settings(BuildContext context) {
    return InitializationSettings(
      android: _androidInit(),
      iOS: _iosInit(context),
    );
  }

  DarwinInitializationSettings _iosInit(BuildContext context) {
    return DarwinInitializationSettings();
  }

  AndroidInitializationSettings _androidInit() =>
      const AndroidInitializationSettings('@drawable/ic_notification');

  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    final NotificationDetails notificationDetails = _getNotificationsDetails();

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  NotificationDetails _getNotificationsDetails() {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      color: Colors.blue,
      colorized: true
    );

    return NotificationDetails(android: androidNotificationDetails);
  }

  /// Devolución de llamada para manejar cuando se activa una notificación
  /// mientras la aplicación está en primer plano.
  ///
  /// Esta propiedad solo se aplica a versiones de iOS anteriores a 10.
  Future<void> onDidReceiveLocalNotification(BuildContext context, int id,
      String? title, String? body, String? payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }

  /// se activa cuando el usuario selecciona una notificación o acción de
  /// notificación que debería mostrar la aplicación/interfaz de usuario.
  Future<void> onDidReceiveNotificationResponse(
    BuildContext context,
    NotificationResponse notificationResponse,
  ) async {}
}
