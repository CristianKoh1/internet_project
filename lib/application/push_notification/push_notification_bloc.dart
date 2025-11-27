import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/push_notification/i_push_notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'push_notification_bloc.freezed.dart';
part 'push_notification_event.dart';
part 'push_notification_state.dart';
  
@Injectable()
class PushNotificationBloc extends Bloc<PushNotificationEvent, PushNotificationState> {
	final IPushNotificationRepository pushNotificationRepository;
	PushNotificationBloc(this.pushNotificationRepository) : super(const PushNotificationState.initial()) {
		on<PushNotificationEvent>((event, emit) async {
			/* await event.map(saveFirebaseToken: (PushNotificationSaveFirebaseToken event) async {
				await _saveFirebaseToken(event, emit);
			}, changeFirebaseToken: (PushNotificationChangeFirebaseToken event) {
				_changeFirebaseToken(event, emit);
			}, reset: (ContactsReset event) { 
        emit(const PushNotificationState.initial());
       }
      ); */
		});
  	}

  void _changeFirebaseToken(PushNotificationChangeFirebaseToken event, Emitter<PushNotificationState> emit) {
    emit(state.copyWith(firabaseToken: event.firebaseToken));
  }

  Future<void> _saveFirebaseToken(PushNotificationSaveFirebaseToken event, Emitter<PushNotificationState> emit) async {
    emit(state.copyWith(loading: true, firebaseTokenResponse: none()));
    final firebaseResponse = await pushNotificationRepository.saveFirebaseToken(event.firebaseToken);

    emit(state.copyWith(
      loading: false,
      firebaseTokenResponse: some(firebaseResponse),
    ));
  }
}
