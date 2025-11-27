import 'package:auto_route/auto_route.dart';
import 'package:moloch_app/router/guards/auth_guard.dart';
import 'package:moloch_app/router/guards/has_password_guard.dart';

import 'app_router.gr.dart';

/// Configuración de enrutador de la aplicación que define todas las rutas y configuraciones necesarias.
///
/// Esta clase extiende la configuración generada por AutoRoute  y proporciona
/// rutas específicas para diferentes plataformas (web y móvil), además de integrar guardias de autenticación.
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => _routes;

  /// Lista de rutas principales de la aplicación, incluyendo rutas condicionales basadas en la plataforma.
  late final _routes = <AutoRoute>[
    AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: LoginPinRoute.page, path: '/loginPin'),
    AutoRoute(page: LoginPasswordRoute.page, path: '/loginWithPasswords'),
    AutoRoute(page: SignUpRoute.page, path: '/signUp'),
    AutoRoute(page: NoClientRoute.page, path: '/noClient'),
    AutoRoute(page: ConfirmInfoRoute.page, path: '/confirmInfo'),
    AutoRoute(
      page: ChangePasswordConfirmPinRoute.page,
      path: '/changePasswordConfirmPin',
    ),

    AutoRoute(
      page: DashboardRoute.page,
      path: '/dashboard',
      initial: true,
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: FirstDashboardRoute.page,
      path: '/firstDashboard',
      guards: [AuthGuard(), HasPasswordGuard()],
    ),
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: FirstHomeRoute.page,
      path: '/firstHome',
      guards: [AuthGuard(), HasPasswordGuard()],
    ),
    AutoRoute(
      page: ChangePasswordRoute.page,
      path: '/changePassword',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: PayRoute.page,
      path: '/pay',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: DetailRoute.page,
      path: '/detail',
      guards: [AuthGuard()],
    ),
  ];
}
