import 'package:moloch_app/domain/core/value_objets.dart/value_object.dart';
import 'package:moloch_app/domain/value_objects/value_failure.dart';
import 'package:fpdart/fpdart.dart';

extension EitherResponseExtension<T> on Option<ValueObject<T>> {
  String? mapValidator({
    required String? Function() none,
    required String? Function(ValueFailure) invalid,
  }) {
    return this.fold(
      none,
      (t) => t.value.fold(
        invalid,
        (t) => null,
      ),
    );
  }

  T getValueOrElse({
    required T Function() orElse,
  }) {
    return this.fold(
      orElse,
      (t) => t.value.fold(
        (l) => orElse.call(),
        (r) => r,
      ),
    );
  }

  bool isValid() {
    return this.fold(
      () => false,
      (t) => t.isValid(),
    );
  }
}
