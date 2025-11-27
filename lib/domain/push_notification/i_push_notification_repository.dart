import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
/// Repositorio para gestionar notificaciones push.
///
/// Este repositorio define un método para guardar el token de Firebase Cloud Messaging (FCM).
@factoryMethod
abstract class IPushNotificationRepository {
  /// Guarda el token de Firebase Cloud Messaging (FCM) en el servidor.
  ///
  /// [firebaseToken]: Token de Firebase a ser guardado.
  ///
  /// Devuelve un [Either] que contiene `Unit` en caso de éxito
  /// o un [OperationFailure] en caso de error.
  Future<Either<OperationFailure, Unit>> saveFirebaseToken(
    String firebaseToken,
  );
}
