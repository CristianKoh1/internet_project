import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart'
    if (dart.library.html) 'package:afinclic_app_modulo_credito/config/crashlytics_stub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/domain/auth/i_auth_repository.dart';
import 'package:moloch_app/domain/local/i_local_repository.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/utils/firebase_manager.dart';
import 'package:moloch_app/presentation/utils/responsive/dialog.dart';
import 'package:moloch_app/router/app_router.gr.dart';

class LogoutUtils {
  bool showExpiredDialog = false;

  static void showLogoutDialog(BuildContext context) {
    showCustomDialog(
      context,
      imageUrl: 'assets/logo/logo.png',
      title: AppLocalizations.of(context).areYouSureYouWantToLogout,
      primaryButtonText: AppLocalizations.of(context).logout,
      primaryButtonCallback: () {
        logout(context);
      },
    );
  }

  static void logout(BuildContext context) {
    clearData(context);
    AutoRouter.of(context).replaceAll([const WelcomeRoute()]);
  }

  static void clearData(BuildContext context) {
    final ILocalRepository localRepository = getIt<ILocalRepository>();
    FirebaseManager.removeToken();
    localRepository.deleteAccount();
  }
}
