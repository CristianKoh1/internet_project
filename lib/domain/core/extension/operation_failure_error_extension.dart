import 'package:moloch_app/domain/enums/operation_failure_error.dart';
import 'package:flutter/material.dart';

extension OperationFailureExtension on OperationFailureError? {
  ///Devuelve la traduccion del error.
  ///
  ///Ejemp. UserNotFound retorna "Usuario no encontrado"
  String getLocal(BuildContext context) {
    switch (this) {
      default:
        return '';
    }
  }
}
