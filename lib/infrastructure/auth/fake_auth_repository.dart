import 'package:moloch_app/domain/auth/i_auth_repository.dart';
import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/request/login_request_model.dart';
import 'package:moloch_app/domain/response/login_response_model.dart';
import 'package:moloch_app/domain/response/send_pin_response_model.dart';
import 'package:moloch_app/infrastructure/utils/fake_utils.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: IAuthRepository)
class FakeAuthRepository implements IAuthRepository {
  @override
  Future<Either<OperationFailure, LoginResponseModel>> login(
    LoginRequestModel loginRequestModel,
  ) async {
    await FakeUtils.delayed();
    return right(
      LoginResponseModel(
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiIiLCJFbWFpbCI6IiIsIkVtYWlsQXZhbCI6ImNyaXN0aWFucm9kcmlnb2tvaHVjMkBnbWFpbC5jb20iLCJJc0F2YWwiOiJ0cnVlIiwiSWRVc3VhcmlvIjoiZTE2NzM5MzUtMDlhMi00YmJjLTljMGMtMDhkZDNjYjgyODFiIiwiSWRTb2xpY2l0dWQiOiI2NiIsIlRpcG9TY29yZUF2YWwiOiIwIiwiZXhwIjoxNzQwMDY3MjY4LCJpc3MiOiJodHRwczovL2FmaW5jbGljLWNyZWRpdG8tdXNhLWF1dGgtZGV2LmF6dXJld2Vic2l0ZXMubmV0LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzUwIn0.FxaA_Ot7q9BxunzoynPt0rZeTc1WWUorgbcWRVWKTkQ',
      ),
    );
  }

  @override
  Future<Either<OperationFailure, LoginResponseModel>> loginPin({
    required String pinCode,
    required String phoneNumber,
    required String clientId,
  }) async {
    await FakeUtils.delayed();
    return right(
      LoginResponseModel(
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiIiLCJFbWFpbCI6IiIsIkVtYWlsQXZhbCI6ImNyaXN0aWFucm9kcmlnb2tvaHVjMkBnbWFpbC5jb20iLCJJc0F2YWwiOiJ0cnVlIiwiSWRVc3VhcmlvIjoiZTE2NzM5MzUtMDlhMi00YmJjLTljMGMtMDhkZDNjYjgyODFiIiwiSWRTb2xpY2l0dWQiOiI2NiIsIlRpcG9TY29yZUF2YWwiOiIwIiwiZXhwIjoxNzQwMDY3MjY4LCJpc3MiOiJodHRwczovL2FmaW5jbGljLWNyZWRpdG8tdXNhLWF1dGgtZGV2LmF6dXJld2Vic2l0ZXMubmV0LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzUwIn0.FxaA_Ot7q9BxunzoynPt0rZeTc1WWUorgbcWRVWKTkQ',
      ),
    );
  }

  @override
  Future<Either<OperationFailure, SendPinResponseModel>> sendPin({
    required String phoneNumber,
  }) async {
    await FakeUtils.delayed();
    return right(SendPinResponseModel(id: '123456', phone: '89'));
  }

  @override
  Future<Either<OperationFailure, LoginResponseModel>> loginWithPassword({
    required String phoneNumber,
    required String password,
  }) async {
    await FakeUtils.delayed();
    return right(
      LoginResponseModel(
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiIiLCJFbWFpbCI6IiIsIkVtYWlsQXZhbCI6ImNyaXN0aWFucm9kcmlnb2tvaHVjMkBnbWFpbC5jb20iLCJJc0F2YWwiOiJ0cnVlIiwiSWRVc3VhcmlvIjoiZTE2NzM5MzUtMDlhMi00YmJjLTljMGMtMDhkZDNjYjgyODFiIiwiSWRTb2xpY2l0dWQiOiI2NiIsIlRpcG9TY29yZUF2YWwiOiIwIiwiZXhwIjoxNzQwMDY3MjY4LCJpc3MiOiJodHRwczovL2FmaW5jbGljLWNyZWRpdG8tdXNhLWF1dGgtZGV2LmF6dXJld2Vic2l0ZXMubmV0LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzUwIn0.FxaA_Ot7q9BxunzoynPt0rZeTc1WWUorgbcWRVWKTkQ',
      ),
    );
  }

  @override
  Future<Either<OperationFailure, Unit>> closeSession() async {
    await FakeUtils.delayed();
    return right(unit);
  }

  @override
  Future<Either<OperationFailure, Unit>> saveFirebaseToken({
    required String token,
  }) async {
    await FakeUtils.delayed();
    return right(unit);
  }
}
