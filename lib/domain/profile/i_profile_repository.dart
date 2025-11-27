import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/response/basic_info_model.dart';
import 'package:moloch_app/domain/response/has_password_response_model.dart';
import 'package:moloch_app/domain/response/plan_model.dart';
import 'package:moloch_app/domain/response/traffic_model.dart';

/// Interfaz del repositorio de autenticación.
///
/// Esta interfaz define métodos para el manejo de autenticación,
/// incluyendo inicio de sesión, solicitud y actualización de PIN, y validación de PIN.
@factoryMethod
abstract class IProfileRepository {
  Future<Either<OperationFailure, Unit>> setPassword({
    required String newPassword,
  });

  Future<Either<OperationFailure, HasPasswordResponseModel>> hasPassword();
  Future<Either<OperationFailure, Unit>> sendPin();
  Future<Either<OperationFailure, Unit>> setPasswordWithPin({
    required String newPassword,
    required String pin,
  });
  Future<Either<OperationFailure, BasicInfoModel>> getBasicInfo();
  Future<Either<OperationFailure, List<PlanModel>>> getPlan();
  Future<Either<OperationFailure, TrafficModel>> getTraffic();
}
