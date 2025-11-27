import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/push_notification/i_push_notification_repository.dart';
import 'package:moloch_app/infrastructure/utils/fake_utils.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: IPushNotificationRepository)
class FakePushNotificationRepository implements IPushNotificationRepository {
  @override
  Future<Either<OperationFailure, Unit>> saveFirebaseToken(
      String firebaseToken) async {
    await FakeUtils.delayed();
    return right(unit);
  }
}
