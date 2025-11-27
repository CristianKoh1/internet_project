import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:fpdart/fpdart.dart';

extension EitherResponseExtension<L, R> on Either<OperationFailure, List<R>> {
  Option<Either<OperationFailure, List<R>>> filterList({
    required bool Function(R) function,
    bool runWhen = true,
  }) {
    return fold(
      (l) => some(left(l)),
      (r) {
        return some(right(runWhen ? r.where(function).toList() : r));
      },
    );
  }

  Option<Either<OperationFailure, List<R>>> updateList(
      {required bool Function(R) function,
      bool runWhen = true,
      required R value}) {
    return fold(
      (l) => some(left(l)),
      (r) {
        return some(
          right(runWhen ? _editRList(r: r, function: function, value: value) : r),
        );
      },
    );
  }

  List<R> _editRList({
    required List<R> r,
    required bool Function(R) function,
    required R value,
  }) {
    int index = r.indexWhere(function);
    if (index != -1) {
      r[index] = value;
    }
    return r.toList();
  }
}
