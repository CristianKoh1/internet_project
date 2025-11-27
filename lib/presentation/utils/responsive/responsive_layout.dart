import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moloch_app/config/enviroment.dart';

///
/// [ResponsiveLayout.]
/// Acepta dos widgets, unos se mostrara en la versión web movil, y el otro en la versión web de escritorio.
/// [@author]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, October 10th, 2023]
/// [@see		StatelessWidget]
/// [@global]
///
class ResponsiveLayout extends StatelessWidget {
  final Widget? webMobileBody;
  final Widget? webDesktopBody;
  final Widget mobile;
  const ResponsiveLayout({
    super.key,
    this.webMobileBody,
    this.webDesktopBody,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if (!kIsWeb) return mobile;

        if (Enviroments.isWebMobile(constrains)) {
          return webMobileBody ?? mobile;
        } else {
          return webDesktopBody ?? mobile;
        }
      },
    );
  }
}
