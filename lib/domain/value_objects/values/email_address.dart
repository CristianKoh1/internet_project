import 'package:moloch_app/domain/core/value_objets.dart/value_object.dart';
import 'package:moloch_app/domain/value_objects/value_failure.dart';
import 'package:fpdart/fpdart.dart';
/// Representa una dirección de correo electrónico válida.
///
/// Esta clase encapsula la lógica de validación para asegurar que una dirección de correo
/// electrónico cumpla con el formato correcto.
class EmailAddress extends ValueObject<String> {
  final Either<ValueFailure, String> value;

  const EmailAddress._(this.value);
  /// Fábrica para crear una instancia de EmailAddress validando la entrada proporcionada.
  ///
  /// Utiliza [_validate] para verificar si la entrada cumple con el formato de correo electrónico válido.
  factory EmailAddress(String input) =>
      EmailAddress._(_validate(input));

}
/// Función privada que realiza la validación de una dirección de correo electrónico.
///
/// Retorna un [Either] que contiene un [ValueFailure] si la dirección no es válida o
/// el valor de la dirección de correo electrónico si es válida.
Either<ValueFailure, String> _validate(String input) {
  const regex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(
      ValueFailure.invalidEmail(failedValue: input),
    );
  }
}