part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial({
    @Default(false) bool loading,
    @Default(Option.none()) Option<EmailAddress> email,
    @Default(Option.none()) Option<PhoneNumber> phoneNumber,
    @Default(Option.none()) Option<Password> password,
    @Default(Option.none()) Option<String> clientId,
    @Default(Option.none()) Option<NotEmpty> name,
    @Default(0) int intents,
    @Default('') String code,
    @Default(Option.none())
    Option<Either<OperationFailure, LoginResponseModel>> loginPinResponseModel,
    @Default(Option.none())
    Option<Either<OperationFailure, SendPinResponseModel>> sendPinResponse,
    @Default(Option.none())
    Option<Either<OperationFailure, LoginResponseModel>>
    loginWithPasswordResponse,
    @Default(Option.none()) Option<bool> termsAccepted,
  }) = _AuthInitial;
}
