import 'package:moloch_app/domain/core/value_objets.dart/value_object.dart';
import 'package:moloch_app/domain/value_objects/value_failure.dart';
import 'package:fpdart/fpdart.dart';

/// Representa un valor no vacío.
///
/// Esta clase encapsula la lógica de validación para asegurar que un valor no esté vacío.
class NotEmpty extends ValueObject<String> {
  final Either<ValueFailure, String> value;

  const NotEmpty._(this.value);
  /// Fábrica para crear una instancia de NotEmpty validando la entrada proporcionada.
  ///
  /// Utiliza [_validate] para verificar si la entrada no está vacía.
  factory NotEmpty(String input) =>
      NotEmpty._(_validate(input));

}
/// Función privada que realiza la validación de un valor no vacío.
///
/// Retorna un [Either] que contiene un [ValueFailure] si el valor está vacío o
/// el valor si no está vacío.
Either<ValueFailure, String> _validate(String input) {
  if (input != '') {
    return right(input);
  } else {
    return left(
      ValueFailure.invalidNotEmpty(failedValue: input),
    );
  }
}