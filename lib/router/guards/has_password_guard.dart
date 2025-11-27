import 'package:auto_route/auto_route.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/domain/profile/i_profile_repository.dart';
import 'package:moloch_app/router/app_router.gr.dart';

/// Esta clase implementa AutoRouteGuard y se utiliza para validar el estado de
/// autenticación del usuario antes de permitir la navegación a rutas protegidas.

class HasPasswordGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final IProfileRepository profileRepository = getIt<IProfileRepository>();

    var hasPasswordResponse = await profileRepository.hasPassword();
    return hasPasswordResponse.fold(
      (failure) {
        resolver.next(true);
      },
      (response) {
        if (!response.hasPassword) {
          router.pushAll([ChangePasswordRoute()]);
        }
        resolver.next(true);
      },
    );
  }
}
