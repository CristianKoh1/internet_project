import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/profile/i_profile_repository.dart';
import 'package:moloch_app/domain/response/basic_info_model.dart';
import 'package:moloch_app/domain/response/has_password_response_model.dart';
import 'package:moloch_app/domain/response/plan_model.dart';
import 'package:moloch_app/domain/response/traffic_model.dart';
import 'package:moloch_app/infrastructure/utils/fake_utils.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: IProfileRepository)
class FakeProfileRepository implements IProfileRepository {
  @override
  Future<Either<OperationFailure, Unit>> setPassword({
    required String newPassword,
  }) async {
    await FakeUtils.delayed();
    return right(unit);
  }

  @override
  Future<Either<OperationFailure, HasPasswordResponseModel>>
  hasPassword() async {
    await FakeUtils.delayed();
    return right(HasPasswordResponseModel(hasPassword: true));
  }

  @override
  Future<Either<OperationFailure, Unit>> sendPin() async {
    await FakeUtils.delayed();
    return right(unit);
  }

  @override
  Future<Either<OperationFailure, Unit>> setPasswordWithPin({
    required String newPassword,
    required String pin,
  }) async {
    await FakeUtils.delayed();
    return right(unit);
  }

  @override
  Future<Either<OperationFailure, BasicInfoModel>> getBasicInfo() async {
    await FakeUtils.delayed();
    return right(
      BasicInfoModel(
        name: "name",
        alias: "alias",
        phone: "phone",
        email: "email",
      ),
    );
  }

  @override
  Future<Either<OperationFailure, List<PlanModel>>> getPlan() async {
    await FakeUtils.delayed();
    return right([
      PlanModel(id: "1", estado: "active", plan: "Unlimited Internet"),
      PlanModel(id: "2", estado: "active", plan: "Unlimited Internet"),
    ]);
  }

  @override
  Future<Either<OperationFailure, TrafficModel>> getTraffic() async{
    await FakeUtils.delayed();
    return right(
      TrafficModel(mes: "mes", subida: "subida", descarga: "descarga")
    );
  }
}
