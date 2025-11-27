import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/auth/i_auth_repository.dart';
import 'package:moloch_app/domain/core/extension/option_object_value_extension.dart';
import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/local/i_local_repository.dart';
import 'package:moloch_app/domain/response/login_response_model.dart';
import 'package:moloch_app/domain/response/send_pin_response_model.dart';
import 'package:moloch_app/domain/value_objects/values/email_address.dart';
import 'package:moloch_app/domain/value_objects/values/not_empty.dart';
import 'package:moloch_app/domain/value_objects/values/password.dart';
import 'package:moloch_app/domain/value_objects/values/phone_number.dart';
part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  final ILocalRepository localRepository;

  AuthBloc(this.authRepository, this.localRepository)
    : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthLogin():
          //await _login(event, emit);
          break;
        case AuthChangeEmail():
          _changeEmail(event, emit);
          break;
        case AuthChangePassword():
          _changePassword(event, emit);
          break;
        case AuthRequestNewPin():
          await _requestNewPin(event, emit);
          break;
        case AuthConfirmNewPinRequestCode():
          await _confirmNewPinRequestCode(event, emit);
          break;
        case AuthUpdatePin():
          await _updatePin(event, emit);
          break;
        case AuthChangeCode():
          _changeCode(event, emit);
          break;
        case AuthLoginPin():
          await _loginPin(event, emit);
          break;
        case AuthValidatePin():
          await _validatePin(event, emit);
          break;
        case AuthChangePhoneNumber():
          await _changePhoneNumber(event, emit);
          break;
        case AuthSendPin():
          await _sendPin(event, emit);
          break;
        case AuthLoginWithPassword():
          await _loginWithPassword(event, emit);
          break;
        case AuthChangeName():
          _changeName(event, emit);
        case AuthChangeClientId():
          _changeClientId(event, emit);
        case AuthChangeTermsAccepted():
          _authChangeTermsAccepted(event, emit);
      }
    });
  }

  void _changeEmail(AuthChangeEmail event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: some(EmailAddress(event.email))));
  }

  void _changePassword(AuthChangePassword event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: some(Password(event.password))));
  }

  Future<void> _loginPin(AuthLoginPin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loading: true, loginPinResponseModel: none()));

    final phoneNumber = state.phoneNumber.getValueOrElse(orElse: () => '');
    final clientId = state.clientId.getOrElse(()=>'');

    final loginResponse = await authRepository.loginPin(
      pinCode: event.pin,
      phoneNumber: phoneNumber,
      clientId: clientId
    );

    await loginResponse.fold((l) => null, (loginResponse) async{
      await localRepository.saveOrUpdateAccount(loginResponse.token);
    });

    await Future.delayed(const Duration(seconds: 2));
    emit(
      state.copyWith(
        loading: false,
        loginPinResponseModel: some(loginResponse),
      ),
    );
  }

  Future<void> _requestNewPin(
    AuthRequestNewPin event,
    Emitter<AuthState> emit,
  ) async {
    /*   emit(state.copyWith(
        loading: true,
        requestNewPinResponse: none(),
        confirmNewPinRequestCodeResponse: none()));

    final requestNewPinResponse = await authRepository.requestNewPin();

    emit(
      state.copyWith(
        loading: false,
        requestNewPinResponse: some(requestNewPinResponse),
      ),
    ); */
  }

  Future<void> _confirmNewPinRequestCode(
    AuthConfirmNewPinRequestCode event,
    Emitter<AuthState> emit,
  ) async {
    /*  emit(
      state.copyWith(
        loading: true,
        requestNewPinResponse: none(),
        confirmNewPinRequestCodeResponse: none(),
      ),
    );

    final confirmNewPinRequestCodeResponse =
        await authRepository.confirmNewPinRequestCode(event.code);

    emit(
      state.copyWith(
        loading: false,
        confirmNewPinRequestCodeResponse:
            some(confirmNewPinRequestCodeResponse),
      ),
    ); */
  }

  Future<void> _updatePin(AuthUpdatePin event, Emitter<AuthState> emit) async {
    /* emit(state.copyWith(loading: true, updatePinResponse: none()));

    final updatePinRequestModel = UpdatePinRequestModel(pin: event.pin);
    final updatePinResponse =
        await authRepository.updatePin(updatePinRequestModel);

    emit(
      state.copyWith(
        loading: false,
        updatePinResponse: some(updatePinResponse),
      ),
    ); */
  }

  void _changeCode(AuthChangeCode event, Emitter<AuthState> emit) {
    emit(state.copyWith(code: event.code));
  }

  Future<void> _validatePin(
    AuthValidatePin event,
    Emitter<AuthState> emit,
  ) async {
    /*  emit(state.copyWith(loading: true, validatePinResponse: none()));

    final validatePinResponse =
        await authRepository.validatePin(pin: event.pin);

    emit(state.copyWith(
      loading: false,
      validatePinResponse: some(validatePinResponse),
    )); */
  }

  _changePhoneNumber(
    AuthChangePhoneNumber event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(phoneNumber: some(PhoneNumber(event.phoneNumber))));
  }

  Future<void> _sendPin(AuthSendPin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loading: true, sendPinResponse: none()));

    final phoneNumber = state.phoneNumber.getValueOrElse(orElse: () => '');
    final sendPinResponse = await authRepository.sendPin(
      phoneNumber: phoneNumber,
    );

    emit(
      state.copyWith(loading: false, sendPinResponse: some(sendPinResponse)),
    );
  }

  Future<void> _loginWithPassword(
    AuthLoginWithPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(loading: true, loginWithPasswordResponse: none()));

    final password = state.password.getValueOrElse(orElse: () => '');
    final phoneNumber = state.phoneNumber.getValueOrElse(orElse: () => '');

    final loginWithPasswordResponse = await authRepository.loginWithPassword(
      phoneNumber: phoneNumber,
      password: password,
    );

    await loginWithPasswordResponse.fold((l) => null, (loginResponse) async{
      await localRepository.saveOrUpdateAccount(loginResponse.token);
    });

    emit(
      state.copyWith(
        loading: false,
        loginWithPasswordResponse: some(loginWithPasswordResponse),
      ),
    );
  }

  void _changeName(AuthChangeName event, Emitter<AuthState> emit) {
    emit(state.copyWith(name: Some(NotEmpty(event.name))));
  }

  void _changeClientId(AuthChangeClientId event, Emitter<AuthState> emit) {
    emit(state.copyWith(clientId: Some(event.id)));
  }
  
  void _authChangeTermsAccepted(AuthChangeTermsAccepted event, Emitter<AuthState> emit) {
    emit(state.copyWith(termsAccepted: Some(event.value)));
  }
}
