import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/core/extension/option_object_value_extension.dart';
import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/profile/i_profile_repository.dart';
import 'package:moloch_app/domain/response/basic_info_model.dart';
import 'package:moloch_app/domain/response/plan_model.dart';
import 'package:moloch_app/domain/response/traffic_model.dart';
import 'package:moloch_app/domain/value_objects/values/password.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileRepository profileRepository;
  ProfileBloc(this.profileRepository) : super(const ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      switch (event) {
        case ProfileChangePassword():
          _changePassword(event, emit);
          break;
        case ProfileSetPassword():
          await _setPassword(event, emit);
          break;
        case ProfileEventPasswordWithPin():
          await _passwordWithPin(event, emit);
          break;
        case ProfileEventSendPin():
          await _sendPin(event, emit);
          break;
        case ProfileChangeConfirmPassword():
          _changeConfirmPassword(event, emit);
          break;
        case ProfileGetBasicInfo():
          await _getBasicInfo(event, emit);
          break;
        case ProfileGetPlan():
          await _getPlan(event, emit);
          break;
        case ProfileGetTraffic():
          await _getTraffic(event, emit);
          break;
      }
    });
  }

  void _changePassword(
    ProfileChangePassword event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(password: some(Password(event.password))));
  }

  Future<void> _setPassword(
    ProfileSetPassword event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true, setPasswordResponse: none()));
    final password = state.password.getValueOrElse(orElse: () => "");
    final profileResponse = await profileRepository.setPassword(
      newPassword: password,
    );
    emit(
      state.copyWith(
        loading: false,
        setPasswordResponse: some(profileResponse),
      ),
    );
  }

  Future<void> _sendPin(
    ProfileEventSendPin event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true, sendPinResponse: none()));
    final sendPinResponse = await profileRepository.sendPin();
    emit(
      state.copyWith(loading: false, sendPinResponse: some(sendPinResponse)),
    );
  }

  Future<void> _passwordWithPin(
    ProfileEventPasswordWithPin event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true, setPasswordResponse: none()));
    var password = event.password;
    var pin = event.pin;
    final setPasswordResponse = await profileRepository.setPasswordWithPin(
      newPassword: password,
      pin: pin,
    );
    emit(state.copyWith(setPasswordResponse: some(setPasswordResponse)));
  }

  void _changeConfirmPassword(
    ProfileChangeConfirmPassword event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(confirmPassword: some(Password(event.password))));
  }

  Future<void> _getBasicInfo(
    ProfileGetBasicInfo event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true, basicInfoResponse: none()));
    final getBasicInfoResponse = await profileRepository.getBasicInfo();
    emit(
      state.copyWith(
        loading: false,
        basicInfoResponse: some(getBasicInfoResponse),
      ),
    );
  }

  Future<void> _getPlan(
    ProfileGetPlan event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true, getPlanResponse: none()));
    final getPlanResponse = await profileRepository.getPlan();
    emit(
      state.copyWith(loading: false, getPlanResponse: some(getPlanResponse)),
    );
  }

  Future<void> _getTraffic(
    ProfileGetTraffic event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true, getPlanResponse: none()));
    final getTrafficResponse = await profileRepository.getTraffic();
    emit(
      state.copyWith(
        loading: false,
        getTrafficResponse: some(getTrafficResponse),
      ),
    );
  }
}
