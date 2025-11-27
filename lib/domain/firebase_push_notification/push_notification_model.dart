import 'package:moloch_app/domain/enums/push_notification_type.dart';
/// Modelo que representa una notificación push.
///
/// Contiene el tipo de notificación push.
class PushNotificationModel {
  final PushNotificationType type;

  /// Crea una instancia de [PushNotificationModel] con el tipo de notificación especificado.
  ///
  /// [type] es requerido y debe ser de tipo [PushNotificationType].
  PushNotificationModel({required this.type});

  /// Crea una instancia de [PushNotificationModel] a partir de un mapa JSON.
  ///
  /// [json] es el mapa JSON que contiene la información de la notificación push.
  ///
  /// Devuelve una instancia de [PushNotificationModel] con el tipo de notificación correspondiente.
   factory PushNotificationModel.fromJson(Map<String, dynamic> json) {
    return PushNotificationModel(
        type: PushNotificationType.values.firstWhere(
            (type) => type.value == json['type'],
            orElse: () => PushNotificationType.unknown));
  }
}
