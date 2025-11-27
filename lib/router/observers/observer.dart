import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Observer personalizado para AutoRoute que escucha los eventos de navegación.
///
/// Esta clase extiende AutoRouterObserver y proporciona lógica personalizada
/// En este caso, se utiliza para disparar un evento a través de un EventBus cuando se regresa
/// a ciertas rutas específicas como 'Home' o 'CheckingCreditBureau'.
class MyObserver extends AutoRouterObserver {
  /// Método invocado cuando se realiza una operación de pop (regreso) en las rutas.
  @override
  void didPop(Route route, Route? previousRoute) {}
}
