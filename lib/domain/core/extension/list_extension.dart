import 'package:collection/collection.dart'; 

extension ListExtension<R> on List<R> {
  R? findWhere(
    bool Function(R) test, {
    String Function(R)? getName, 
  }) {
    if (getName == null) return firstWhereOrNull(test); 

    // Primero busca los elementos que comienzan con el texto ingresado
    R? firstMatch = firstWhereOrNull((item) => test(item) && 
        getName(item).toLowerCase().startsWith(getName(this.first).toLowerCase()));

    if (firstMatch != null) return firstMatch;

    // Si no encontró coincidencias al inicio, busca en cualquier parte del texto
    return firstWhereOrNull(test);
  }
}
