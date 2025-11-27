class RFCValidator {
  final String nombres;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final DateTime fechaNacimiento;

  RFCValidator({
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
  });

  /// Método para generar los primeros 10 caracteres del RFC
  String generarRFCBase() {
    String rfc = obtenerLetrasApellido(apellidoPaterno);

    /// Añadir la primera letra del apellido materno o "X" si no hay apellido materno
    rfc += apellidoMaterno.isNotEmpty ? apellidoMaterno[0].toUpperCase() : 'X';

    rfc += nombres[0].toUpperCase();

    // Añadir la fecha de nacimiento en formato YYMMDD
    rfc += fechaNacimiento.year.toString().substring(2);
    rfc += fechaNacimiento.month.toString().padLeft(2, '0');
    rfc += fechaNacimiento.day.toString().padLeft(2, '0');

    return rfc;
  }

  // Método para validar si los primeros 10 caracteres del RFC son correctos
  bool validarRFC(String rfcProporcionado) {
    if (this.nombres == '' || this.apellidoMaterno==''|| this.fechaNacimiento==''||this.apellidoPaterno=='') {
      return true;
    }

    if (rfcProporcionado.length != 13) {
      return false;
    }

    // Generar el RFC calculado
    String rfcGeneradoBase = generarRFCBase();

    return rfcProporcionado.toUpperCase().substring(0, 10) == rfcGeneradoBase.toUpperCase();
  }

  String obtenerLetrasApellido(String apellido) {
    String primeraLetra = apellido[0].toUpperCase();
    String primeraVocal =
        apellido.substring(1).toUpperCase().split('').firstWhere(
              (letra) => 'AEIOU'.contains(letra),
              orElse: () => '',
            );
    return primeraLetra + primeraVocal;
  }
}
