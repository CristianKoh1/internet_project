import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive.dart';

/// Este widget proporciona un Scaffold personalizado con manejo automático de la
/// responsividad para dispositivos web y móviles. Si la aplicación se está ejecutando
/// en un dispositivo web, limita el ancho del cuerpo (`body`) para que se vea
/// adecuadamente en pantallas grandes. En dispositivos móviles, utiliza el ancho máximo
/// disponible.
///
/// Parámetros:
/// - `body`: El contenido principal del esquema Scaffold. Debe ser un widget no nulo.
/// - `appBar`: Un widget de AppBar opcional que se muestra en la parte superior del esquema.
///
/// Ejemplo de uso:
/// ```dart
/// WebFriendlyScaffold(
///   appBar: AppBar(title: Text('Mi App')),
///   body: MiContenido(),
/// )
/// ```
class WebFriendlyScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final double maxWidthWeb;
  final bool? resizeToAvoidBottomInset;

  /// Crea un nuevo Scaffold que centra el body en la version web.
  /// Ejemplo de uso:
  /// ```dart
  /// WebFriendlyScaffold(
  ///   appBar: AppBar(title: Text('Mi App')),
  ///   body: MiContenido(),
  /// )
  /// ```
  const WebFriendlyScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.maxWidthWeb = 45,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    if (!kIsWeb) {
      return Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: appBar,
        body: body,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      body: Center(
        child: LayoutBuilder(builder: (context, constrains) {
          final double maxWidth;
          if (constrains.maxWidth < 600) {
            maxWidth = 90;
          } else if (constrains.maxWidth >= 600 &&
              constrains.maxWidth <= 1000) {
            maxWidth = 60;
          } else {
            maxWidth = maxWidthWeb;
          }
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: responsive.wp(maxWidth),
            ),
            child: body,
          );
        }),
      ),
    );
  }
}
