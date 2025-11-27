part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login() = AuthLogin;
  const factory AuthEvent.changePassword({required String password}) =
      AuthChangePassword;
  const factory AuthEvent.changeEmail({required String email}) =
      AuthChangeEmail;
  const factory AuthEvent.changeName({required String name}) =
      AuthChangeName;
  const factory AuthEvent.changePhoneNumber({required String phoneNumber}) =
      AuthChangePhoneNumber;
  const factory AuthEvent.changeClientId({required String id}) =
      AuthChangeClientId;
  const factory AuthEvent.changeCode({required String code}) = AuthChangeCode;
  const factory AuthEvent.requestNewPin() = AuthRequestNewPin;
  const factory AuthEvent.confirmNewPinRequestCode({required String code}) =
      AuthConfirmNewPinRequestCode;
  const factory AuthEvent.updatePin({required String pin}) = AuthUpdatePin;
  const factory AuthEvent.loginPin({required String pin}) = AuthLoginPin;
  const factory AuthEvent.validatePin({required String pin}) = AuthValidatePin;
  const factory AuthEvent.sendPin() = AuthSendPin;
  const factory AuthEvent.loginWithPassword() = AuthLoginWithPassword;
  const factory AuthEvent.changeTermsAccepted({required bool value}) = AuthChangeTermsAccepted;

}
