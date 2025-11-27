import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_failure.freezed.dart';

@freezed
abstract class OperationFailure with _$OperationFailure {
  const factory OperationFailure({
    int? code,
    String? message,
  }) = _OperationFailure;
}