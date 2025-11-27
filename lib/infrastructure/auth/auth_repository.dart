import 'package:moloch_app/domain/auth/i_auth_repository.dart';
import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/request/login_request_model.dart';
import 'package:moloch_app/domain/response/login_response_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/response/send_pin_response_model.dart';
import 'package:moloch_app/infrastructure/core/http_client.dart';
import 'package:moloch_app/infrastructure/utils/response_decode.dart';

/// Implementación concreta de [IAuthRepository] que utiliza un cliente HTTP para interactuar con un servicio externo relacionado con la autenticación y gestión de PIN.
///
/// Esta clase se registra como un singleton perezoso y proporciona métodos para iniciar sesión con contraseña, solicitar un nuevo PIN, confirmar código de solicitud de PIN,
/// actualizar PIN, iniciar sesión con PIN, y validar PIN.
@prod
@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final HttpClient _httpClient;

  AuthRepository(this._httpClient);

  @override
  Future<Either<OperationFailure, LoginResponseModel>> login(
    LoginRequestModel loginRequestModel,
  ) async {
    try {
      final response = await _httpClient.post(
        endpoint: '/auth/v1/autenticacion/contrasena/iniciar-sesion',
        body: loginRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        final responseModel = responseDecode<LoginResponseModel>(
          response,
          (json) => LoginResponseModel.fromJson(json),
        );

        final LoginResponseModel? data = responseModel.data;
        if (responseModel.status && data != null) {
          return right(data);
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

  @override
  Future<Either<OperationFailure, LoginResponseModel>> loginPin({
    required String pinCode,
    required String phoneNumber,
    required String clientId,
  }) async {
    try {
      final response = await _httpClient.post(
        endpoint: '/PublicAuthController/loginWithPin',
        body: {'pin_code': pinCode, 'phone_number': phoneNumber,'client_id': clientId},
      );

      final responseModel = responseDecode<LoginResponseModel>(
        response,
        (json) => LoginResponseModel.fromJson(json),
      );

      final LoginResponseModel? data = responseModel.data;
      if (responseModel.status && data != null) {
        return right(data);
      } else {
        return left(
          OperationFailure(
            code: response.statusCode,
            message: responseModel.message,
          ),
        );
      }
    } catch (e) {
      return left(OperationFailure());
    }
  }

  @override
  Future<Either<OperationFailure, SendPinResponseModel>> sendPin({
    required String phoneNumber,
  }) async {
    try {
      final response = await _httpClient.post(
        endpoint: '/PublicAuthController/sendPinCode',
        body: {'phone_number': phoneNumber},
      );

      final responseModel = responseDecode<SendPinResponseModel>(
        response,
        (json) => SendPinResponseModel.fromJson(json),
      );

      final SendPinResponseModel? data = responseModel.data;
      if (responseModel.status && data != null) {
        return right(data);
      } else {
        return left(
          OperationFailure(
            code: response.statusCode,
            message: responseModel.message,
          ),
        );
      }
    } catch (e) {
      return left(OperationFailure());
    }
  }
  
  @override
  Future<Either<OperationFailure, LoginResponseModel>> loginWithPassword({required String phoneNumber, required String password}) async{
    try {
      final response = await _httpClient.post(
        endpoint: '/PublicAuthController/loginWithPassword',
        body: {'password': password, 'phone_number': phoneNumber},
      );

      final responseModel = responseDecode<LoginResponseModel>(
        response,
        (json) => LoginResponseModel.fromJson(json),
      );

      final LoginResponseModel? data = responseModel.data;
      if (responseModel.status && data != null) {
        return right(data);
      } else {
        return left(
          OperationFailure(
            code: response.statusCode,
            message: responseModel.message,
          ),
        );
      }
    } catch (e) {
      return left(OperationFailure());
    }
  }
  @override
  Future<Either<OperationFailure, Unit>> saveFirebaseToken({required String token}) async{
    try {
      final response = await _httpClient.post(
        endpoint: '/PublicUserController/save_firebase_token',
        body: {'token': token},
      );

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
    } catch (e) {
      return left(OperationFailure());
    }
  }
  
  @override
  Future<Either<OperationFailure, Unit>> closeSession() async{
      try {
      final response = await _httpClient.post(
        endpoint: '/PublicUserController/close_session',
      );

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
    } catch (e) {
      return left(OperationFailure());
    }
  }
}
