import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failure.freezed.dart';
/// Representa los diferentes tipos de errores de valor que pueden ocurrir.
///
/// Esta clase utiliza Freezed para definir errores específicos como resultados de errores de valor,
/// como direcciones de correo electrónico o números de teléfono inválidos.
@freezed
abstract class ValueFailure with _$ValueFailure {
  /// Error que indica que una dirección de correo electrónico es inválida.
  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = _InvalidEmail;
  /// Error que indica que un número de teléfono es inválido.
  const factory ValueFailure.invalidPhoneNumber({
    required String failedValue,
  }) = _InvalidPhoneNumber;
  /// Error que indica que un valor no está vacío.
  const factory ValueFailure.invalidNotEmpty({
    required String failedValue,
  }) = _InvalidNotEmpty;
  /// Error que indica que un password es inválido.
  const factory ValueFailure.invalidPassword({
    required String failedValue,
  }) = _InvalidPassword;
}
