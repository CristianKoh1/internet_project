import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/request/login_request_model.dart';
import 'package:moloch_app/domain/response/login_response_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/response/send_pin_response_model.dart';

/// Interfaz del repositorio de autenticación.
///
/// Esta interfaz define métodos para el manejo de autenticación,
/// incluyendo inicio de sesión, solicitud y actualización de PIN, y validación de PIN.
@factoryMethod
abstract class IAuthRepository {
  /// Inicia sesión con las credenciales proporcionadas.
  ///
  /// [loginRequestModel] El modelo de solicitud de inicio de sesión que contiene las credenciales.
  ///
  /// Devuelve un `Either` que contiene un `OperationFailure` en caso de fallo,
  /// o un `LoginResponseModel` en caso de éxito.
  Future<Either<OperationFailure, LoginResponseModel>> login(
    LoginRequestModel loginRequestModel,
  );

  /// Inicia sesión utilizando un PIN.
  ///
  /// [pin] El PIN que debe ser utilizado para iniciar sesión.
  ///
  /// Devuelve un `Either` que contiene un `OperationFailure` en caso de fallo,
  /// o `Unit` en caso de éxito.
  Future<Either<OperationFailure, LoginResponseModel>> loginPin({
    required String pinCode,
    required String phoneNumber,
    required String clientId,
  });

  Future<Either<OperationFailure, LoginResponseModel>> loginWithPassword({
    required String phoneNumber,
    required String password,
  });

  Future<Either<OperationFailure, SendPinResponseModel>> sendPin({
    required String phoneNumber,
  });

  Future<Either<OperationFailure, Unit>> saveFirebaseToken({
    required String token,
  });

  Future<Either<OperationFailure, Unit>> closeSession();
}
