import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';

extension EitherResponseExtension<L, R> on Option<Either<OperationFailure, R>> {
  Widget customGetResponse({
    required Widget Function() loading,
    required Widget Function(OperationFailure) error,
    required Widget Function(R) response,
  }) {
    return fold(
      () => loading(),
      (either) => either.fold(
        (failure) => error(failure),
        (successData) => response(successData),
      ),
    );
  }

  void customListenerResponse({
    void Function(OperationFailure)? error,
    void Function(R)? response,
  }) {
    return fold(
      () => () {},
      (either) => either.fold(
        (failure) => error == null ? {} : error(failure),
        (successData) => response == null ? {} : response(successData),
      ),
    );
  }

  T getValueOrElse<T>({
    required T Function(R) getValue,
    required T Function() orElse,
  }) {
    return fold(
      () => orElse(),
      (t) => t.fold(
        (l) => orElse(),
        (either) => getValue(either),
      ),
    );
  }
}
