import 'dart:convert';

import 'package:flutter/material.dart' hide Key;
import 'package:flutter/services.dart';
import 'package:flutter_secure_dotenv/flutter_secure_dotenv.dart';

part 'enviroment.g.dart';

/// Clase `Enviroments` para configurar y gestionar variables de entorno seguras.
///
/// Esta clase proporciona métodos y propiedades para configurar y acceder
/// a variables de entorno seguras, como URLs de la API, símbolos de dinero,
/// y límites de ancho de dispositivos móviles web.
class Enviroments {
  /// Configura dotenv cargando y decodificando las claves de encriptación.
  ///
  /// Este método carga un archivo JSON que contiene la clave de encriptación
  /// y el vector de inicialización (IV), y luego configura dotenv usando estos valores.
  static Future<void> setUpDotenv() async {
    final json = await rootBundle.loadString('encryption_key.json');
    final secretsMap = jsonDecode(json) as Map<String, dynamic>;
    final encryptionKey = secretsMap['ENCRYPTION_KEY'] as String;
    final iv = secretsMap['IV'] as String;
    dotenv = Env(encryptionKey, iv);
  }

  /// Instancia de `Env` para acceder a las variables de entorno seguras.
  static late final Env dotenv;

  /// URL de la API obtenida de las variables de entorno.
  static String apiURL = dotenv.apiUrl;

  /// Límite de ancho para dispositivos móviles web obtenido de las variables de entorno.
  static double webMobileWidthLimit = dotenv.webMobileWidthLimit;

  /// Símbolo de dinero obtenido de las variables de entorno.
  static String moneySymbol = dotenv.moneySymbol;

  /// Determina si el dispositivo es un móvil web basado en las restricciones de ancho.
  ///
  /// Retorna `true` si el ancho máximo de las restricciones es menor al límite de ancho
  /// para móviles web.
  static bool isWebMobile(BoxConstraints constrains) =>
      constrains.maxWidth < webMobileWidthLimit;

  /// Entorno de la aplicación obtenido de las variables de entorno.
  static String appEnv = dotenv.appEnv;
}


@DotEnvGen(fieldRename: FieldRename.screamingSnake)
abstract class Env {
  /// Constructor de la fábrica para crear una instancia de `Env`.
  const factory Env(String encryptionKey, String iv) = _$Env;

  /// Constructor constante privado.
  const Env._();

  /// URL de la API.
  String get apiUrl;

  /// Límite de ancho para dispositivos móviles web.
  double get webMobileWidthLimit;

  /// Símbolo de dinero.
  String get moneySymbol;

  /// Entorno de la aplicación.
  String get appEnv;
}
