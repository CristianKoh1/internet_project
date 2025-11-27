import 'package:moloch_app/domain/core/value_objets.dart/value_object.dart';
import 'package:moloch_app/domain/value_objects/value_failure.dart';
import 'package:fpdart/fpdart.dart';
/// Representa una contraseña válida con los siguientes requisitos:
/// - Al menos una letra mayúscula
/// - Al menos una letra minúscula
/// - Al menos un número (0-9)
/// - Al menos uno de estos símbolos especiales: !, $, @, %
/// - Longitud exacta de 8 caracteres
class Password extends ValueObject<String> {
  final Either<ValueFailure, String> value;

  const Password._(this.value);

  factory Password(String input) => Password._(_validate(input));
}

Either<ValueFailure, String> _validate(String input) {
  // Verificar longitud exacta de 8 caracteres
  if (input.length < 8) {
    return left(ValueFailure.invalidPassword(failedValue: input));
  }

  // Verificar al menos una mayúscula
  if (!input.contains(RegExp(r'[A-Z]'))) {
    return left(ValueFailure.invalidPassword(failedValue: input));
  }

  // Verificar al menos una minúscula
  if (!input.contains(RegExp(r'[a-z]'))) {
    return left(ValueFailure.invalidPassword(failedValue: input));
  }

  // Verificar al menos un número
  if (!input.contains(RegExp(r'[0-9]'))) {
    return left(ValueFailure.invalidPassword(failedValue: input));
  }

  // Verificar al menos un carácter especial (cualquier carácter no alfanumérico)
  if (!input.contains(RegExp(r'[^a-zA-Z0-9]'))) {
    return left(ValueFailure.invalidPassword(failedValue: input));
  }

  // Si pasa todas las validaciones
  return right(input);
}