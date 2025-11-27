import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/push_notification/i_push_notification_repository.dart';
import 'package:moloch_app/infrastructure/core/http_client.dart';
import 'package:moloch_app/infrastructure/utils/response_decode.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
/// Repositorio que implementa la interfaz [IPushNotificationRepository] para manejar operaciones relacionadas con notificaciones push.
///
/// Utiliza un [HttpClient] para realizar solicitudes HTTP y decodificar las respuestas usando [responseDecode].
@prod
@LazySingleton(as: IPushNotificationRepository)
class PushNotificationRepository implements IPushNotificationRepository {
  final HttpClient _httpClient;

  PushNotificationRepository(this._httpClient);
   /// Guarda el token de Firebase para recibir notificaciones push.
  ///
  /// Recibe [firebaseToken] como parámetro para ser almacenado en el servidor.
  /// Retorna un [Future] que puede contener un [Either] con [unit] si la operación fue exitosa,
  /// o un [OperationFailure] si hubo algún error.
  @override
  Future<Either<OperationFailure, Unit>> saveFirebaseToken(
      String firebaseToken) async {
    try {
      final response = await _httpClient.post(
        endpoint: '/notificaciones/v1/register',
        body: {'token': firebaseToken},
      );

      if (response.statusCode == 200) {
        final responseModel = responseDecode(
          response,
          (json) => null,
        );
        if (responseModel.status) {
          return right(unit);
        } else {
          return left(
            OperationFailure(
              code: response.statusCode,
              message: responseModel.message,
            ),
          );
        }
      }
      return left(OperationFailure());
    } catch (e) {
      return left(OperationFailure());
    }
  }
}
