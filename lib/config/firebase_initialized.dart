

import 'package:firebase_core/firebase_core.dart';
import 'package:moloch_app/firebase_options.dart';

/// Inicializa Firebase para la aplicación.
///
/// Este método verifica si la plataforma es web y, de no serlo,
/// inicializa Firebase con el nombre de la aplicación  y las
/// opciones específicas para la plataforma actual proporcionadas
/// por [DefaultFirebaseOptions].
Future<void> firebaseInitialized() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
