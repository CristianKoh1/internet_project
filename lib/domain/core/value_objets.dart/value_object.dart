import 'package:moloch_app/domain/value_objects/value_failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure, T> get value;

  bool isValid() => value.isRight();
  bool isInvalid() => value.isLeft();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && value == other.value;
  }
}
