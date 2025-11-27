part of 'profile_bloc.dart';

@freezed
abstract class ProfileState with _$ProfileState {
	const factory ProfileState.initial({
    @Default(false) bool loading,
    @Default(Option.none()) Option<Password> password,
    @Default(Option.none()) Option<Password> confirmPassword,
    @Default(Option.none())
    Option<Either<OperationFailure, Unit>> setPasswordResponse,
    @Default(Option.none())
    Option<Either<OperationFailure, Unit>> sendPinResponse,
    @Default(Option.none())
    Option<Either<OperationFailure, BasicInfoModel>> basicInfoResponse,
    @Default(Option.none())
    Option<Either<OperationFailure, TrafficModel>> getTrafficResponse,
    @Default(Option.none())
    Option<Either<OperationFailure, List<PlanModel>>> getPlanResponse,
	  }) = _ProfileInitial;
}	
