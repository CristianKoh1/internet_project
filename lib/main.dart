import 'package:moloch_app/config/create_observer.dart';
import 'package:moloch_app/config/firebase_initialized.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/config/enviroment.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/router/app_router.dart';
import 'package:moloch_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Función principal de la aplicación.
///
/// Configura las dependencias necesarias y inicializa la aplicación.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Enviroments.setUpDotenv();
  await firebaseInitialized();
  //crashlyticsInitialized();
  configureDependencies();
  //await fingerprintInitialized();
  /*
  HttpOverrides.global = MyHttpOverrides();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15)); 
  */
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Instancia del enrutador de la aplicación.
  final AppRouter appRouter = AppRouter();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Moloch App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeClass.lightTheme,
      routerConfig: appRouter.config(
        navigatorObservers: () => createNavigatorObservers(),
      ),
      builder: (_, widget) {
        return SafeArea(top: false,bottom: true,child: widget!);
      },
    );
  }
}
