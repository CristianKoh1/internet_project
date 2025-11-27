import 'package:auto_route/auto_route.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/domain/local/i_local_repository.dart';
import 'package:moloch_app/router/app_router.gr.dart';

/// Esta clase implementa AutoRouteGuard y se utiliza para validar el estado de
/// autenticación del usuario antes de permitir la navegación a rutas protegidas.

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final ILocalRepository localRepository = getIt<ILocalRepository>();

    /// Obtener el token de autenticación del repositorio local.
    final token = await localRepository.getActiveToken();

    // Si no hay token, redirigir al usuario a la pantalla de bienvenida.
    if (token == null) {
      router.pushAll([const WelcomeRoute()]);
      return;
    }
    /*   bool hasExpired = JwtDecoder.isExpired(token);

    if (hasExpired) {
      router.pushAll([const WelcomeRoute(),LoginPasswordRoute()]);
      return;
    } */

    // Permitir la navegación a la ruta solicitada si todas las validaciones son exitosas.
    resolver.next(true);
  }
}
