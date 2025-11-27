import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringCasingExtension on String {
  ///Devuelve una cadena de String formateadas a cada palabra en mayuscula primer letra.
  ///
  ///Ejemplo: BIENVENIDO JUAN = Bienvenido Juan.
  ///
  ///El parametro split es de tipo string e inidca la separacion que tenga la cadena
  ///por defecto esta definido a que la cadena venga separada por un espacio vacio
  ///pero podrias modificarlo como tu gustes si el caso fuera diferente.
  String toTitleCase({
    String split = ' ',
  }) {
    // Dividir el texto en palabras
    List<String> words = this.toLowerCase().split(split);

    // Capitalizar la primera letra de cada palabra
    List<String> capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        if (word.length > 2) {
          return word[0].toUpperCase() + word.substring(1);
        }
        return word.toLowerCase();
      } else {
        return word;
      }
    }).toList();

    // Unir las palabras capitalizadas
    return capitalizedWords.join(' ');
  }

  /// Sanitiza la cadena para evitar inyecciones de HTML, SQL, etc.
  /// También permite especificar la longitud máxima del string, por defecto 500.
  String sanitize({int maxLength = 500}) {
    // Reemplaza caracteres peligrosos para XSS
    String sanitized = this
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;');

    sanitized = sanitized.replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '');
    sanitized = sanitized.trim();

    if (sanitized.length > maxLength) {
      sanitized = sanitized.substring(0, maxLength);
    }

    return sanitized;
  }

  String maxLength({int maxLength = 150}) {
    if (this.length > maxLength) return this.substring(0, maxLength);

    return this;
  }

  /// Remueve los acentos de una cadena de caracteres.
  ///
  /// Esta función reemplaza los caracteres con acentos por sus equivalentes sin acento.
  /// Ejemplo: "Canción" se convierte en "Cancion".
  String removeAccents() {
    const accents = 'áàäâãéèëêíìïîóòöôõúùüûñÁÀÄÂÃÉÈËÊÍÌÏÎÓÒÖÔÕÚÙÜÛÑ';
    const noAccents = 'aaaaaeeeeiiiiooooouuuunAAAAAEEEEIIIIOOOOOUUUUN';

    String result = '';
    for (int i = 0; i < this.length; i++) {
      int index = accents.indexOf(this[i]);
      if (index != -1) {
        result += noAccents[index];
      } else {
        result += this[i];
      }
    }
    return result;
  }

  /// Convierte la cadena en un hash SHA-256.
  String toSha256() {
    var bytes = utf8.encode(this);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
