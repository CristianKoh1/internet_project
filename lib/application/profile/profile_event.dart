part of 'profile_bloc.dart';
	
@freezed
sealed class ProfileEvent with _$ProfileEvent {
	const factory ProfileEvent.changePassword({required String password}) =
      ProfileChangePassword;
	const factory ProfileEvent.changeConfirmPassword({required String password}) =
      ProfileChangeConfirmPassword;
  const factory ProfileEvent.setPassword() = ProfileSetPassword;
  const factory ProfileEvent.changePasswordWithPin({required String pin,required String password}) =
      ProfileEventPasswordWithPin;
  const factory ProfileEvent.sendPin() =
      ProfileEventSendPin;
  const factory ProfileEvent.getBasicInfo() = ProfileGetBasicInfo;
  const factory ProfileEvent.getPlan() = ProfileGetPlan;
  const factory ProfileEvent.getTraffic() = ProfileGetTraffic;
}	
