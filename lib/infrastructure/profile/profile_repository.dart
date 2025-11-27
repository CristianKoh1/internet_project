import 'package:moloch_app/domain/auth/i_auth_repository.dart';
import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/profile/i_profile_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/response/basic_info_model.dart';
import 'package:moloch_app/domain/response/has_password_response_model.dart';
import 'package:moloch_app/domain/response/plan_model.dart';
import 'package:moloch_app/domain/response/traffic_model.dart';
import 'package:moloch_app/infrastructure/core/http_client.dart';
import 'package:moloch_app/infrastructure/utils/response_decode.dart';

/// Implementación concreta de [IAuthRepository] que utiliza un cliente HTTP para interactuar con un servicio externo relacionado con la autenticación y gestión de PIN.
///
/// Esta clase se registra como un singleton perezoso y proporciona métodos para iniciar sesión con contraseña, solicitar un nuevo PIN, confirmar código de solicitud de PIN,
/// actualizar PIN, iniciar sesión con PIN, y validar PIN.
@prod
@LazySingleton(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  final HttpClient _httpClient;

  ProfileRepository(this._httpClient);
  
  @override
  Future<Either<OperationFailure, Unit>> setPassword({required String newPassword}) async{
    try {
      final response = await _httpClient.post(
        endpoint: '/PublicProfileController/setPassword',
        body: {'new_password': newPassword},
      );

      final responseModel = responseDecode(response, (json) => null);
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
  Future<Either<OperationFailure, HasPasswordResponseModel>> hasPassword() async{
     try {
      final response = await _httpClient.get(
        endpoint: '/PublicProfileController/hasPassword',
      );

      final responseModel = responseDecode<HasPasswordResponseModel>(
        response,
        (json) => HasPasswordResponseModel.fromJson(json),
      );

      final HasPasswordResponseModel? data = responseModel.data;
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
  Future<Either<OperationFailure, Unit>> sendPin() async{
   try {
      final response = await _httpClient.post(
        endpoint: '/PublicProfileController/sendPin',
      );

      final responseModel = responseDecode(response, (json) => null);
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
  Future<Either<OperationFailure, Unit>> setPasswordWithPin({required String newPassword, required String pin}) async{
      try {
      final response = await _httpClient.post(
        endpoint: '/PublicProfileController/setPasswordWithPin',
        body: {'new_password': newPassword,'pin': pin},
      );

      final responseModel = responseDecode(response, (json) => null);
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
  Future<Either<OperationFailure, BasicInfoModel>> getBasicInfo() async {
    try {
      final response = await _httpClient.get(
        endpoint: '/PublicProfileController/get_basic_info',
      );

      final responseModel = responseDecode<BasicInfoModel>(
        response,
        (json) => BasicInfoModel.fromJson(json),
      );

      final BasicInfoModel? data = responseModel.data;
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
  Future<Either<OperationFailure, List<PlanModel>>> getPlan() async {
    try {
      final response = await _httpClient.get(
        endpoint: '/PublicUserController/get_current_plan',
      );

      final responseModel = responseDecode<List<PlanModel>>(
        response,
        (json) => (json as List).map((e) => PlanModel.fromJson(e)).toList(),
      );

      final List<PlanModel>? data = responseModel.data;
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
  Future<Either<OperationFailure, TrafficModel>> getTraffic() async {
    try {
      final response = await _httpClient.get(
        endpoint: '/PublicUserController/get_traffic_total_month',
      );

      final responseModel = responseDecode<TrafficModel>(
        response,
        (json) => TrafficModel.fromJson(json),
      );

      final TrafficModel? data = responseModel.data;
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
}
