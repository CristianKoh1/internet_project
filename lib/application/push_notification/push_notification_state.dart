part of 'push_notification_bloc.dart';

@freezed
abstract class PushNotificationState with _$PushNotificationState {
	const factory PushNotificationState.initial({
		@Default(false) bool loading,
		@Default('') String firabaseToken,
		@Default(Option.none())
		Option<Either<OperationFailure, Unit>> firebaseTokenResponse,
	  }) = _PushNotificationInitial;
}	
