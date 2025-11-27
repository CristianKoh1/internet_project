import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:fpdart/fpdart.dart';

extension EitherResponseExtension<L, R>
    on Option<Either<OperationFailure, List<R>>> {
  Option<Either<OperationFailure, List<R>>> addToList(
      Either<OperationFailure, R> itemResponse) {
    final List<R> newItems = itemResponse.fold((l) => [], (t) => [t]);

    return fold(
      () => some(right(newItems)),
      (t) => t.fold(
        (l) => some(right(newItems)),
        (r) {
          final List<R> newList = [...r, ...newItems];
          return some(right(newList));
        },
      ),
    );
  }

  Option<Either<OperationFailure, List<R>>> filterList({
    required bool Function(R) function,
    bool runWhen = true,
  }) {
    return fold(
      () => none(),
      (t) => t.fold(
        (l) => some(left(l)),
        (r) {
          return some(right(runWhen ? r.where(function).toList() : r));
        },
      ),
    );
  }

  Option<Either<OperationFailure, List<R>>> updateList({
    required bool Function(R) function,
    bool runWhen = true,
    required R value,
  }) {
    return fold(
      () => none(),
      (t) => t.fold(
        (l) => some(left(l)),
        (r) {
          return some(right(
              runWhen ? _editRList(r: r, test: function, value: value) : r));
        },
      ),
    );
  }

  Option<Either<OperationFailure, List<R>>> deleteFromList({
    required bool Function(R) function,
    required R value,
  }) {
    return fold(
      () => none(),
      (t) => t.fold(
        (l) => some(left(l)),
        (r) {
          int index = r.indexWhere(function);
          r.removeAt(index);
          return some(right(r));
        },
      ),
    );
  }

  List<R> _editRList({
    required List<R> r,
    required bool Function(R) test,
    required R value,
  }) {
    int index = r.indexWhere(test);
    if (index != -1) {
      r[index] = value;
    }
    return r.toList();
  }

  List<R>? getList() {
    return fold(() => null, (t) => t.fold((l) => null, (r) => r));
  }
}
