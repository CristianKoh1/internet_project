import 'package:moloch_app/domain/core/value_objets.dart/value_object.dart';
import 'package:moloch_app/domain/value_objects/value_failure.dart';
import 'package:fpdart/fpdart.dart';

/// Representa un número de teléfono válido.
///
/// Esta clase encapsula la lógica de validación para asegurar que un número de teléfono cumple con las reglas especificadas.
class PhoneNumber extends ValueObject<String> {
  final Either<ValueFailure, String> value;

  const PhoneNumber._(this.value);
  /// Fábrica para crear una instancia de PhoneNumber validando la entrada proporcionada.
  ///
  /// Utiliza [_validate] para verificar si la entrada es un número de teléfono válido.
  factory PhoneNumber(String input) =>
      PhoneNumber._(_validate(input));

}
/// Función privada que realiza la validación de un número de teléfono.
///
/// Retorna un [Either] que contiene un [ValueFailure] si el número de teléfono es inválido o
/// el número de teléfono si es válido.
Either<ValueFailure, String> _validate(String input) {
  
  if (input.isNotEmpty && input.length <= 12) {
    return right(input);
  } else {
    return left(
      ValueFailure.invalidPhoneNumber(failedValue: input),
    );
  }
}