part of 'push_notification_bloc.dart';
	
@freezed
sealed class PushNotificationEvent with _$PushNotificationEvent {
	const factory PushNotificationEvent.saveFirebaseToken(
		{required String firebaseToken}) = PushNotificationSaveFirebaseToken;

	const factory PushNotificationEvent.changeFirebaseToken({required String firebaseToken}) =
		PushNotificationChangeFirebaseToken;
  const factory PushNotificationEvent.reset() = ContactsReset;
}	
