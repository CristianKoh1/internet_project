import 'package:moloch_app/domain/core/event/event_bus.dart';
import 'package:moloch_app/domain/enums/push_notification_type.dart';
import 'package:moloch_app/domain/firebase_push_notification/push_notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PayloadNotificationManager {
  static void init(RemoteMessage message) {
    _updateBanner();
    /* final pushNotificationModel = PushNotificationModel.fromJson(message.data);
    
    switch (pushNotificationModel.type) {
      case PushNotificationType.updatedApplication:
        _updateBanner();
        break;
      default:
        _updateBanner();
    } */
  }

  static void _updateBanner() {
    eventBus.fire(true);
  }
}
