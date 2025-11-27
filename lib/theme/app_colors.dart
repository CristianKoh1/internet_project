import 'package:flutter/material.dart';

/// Esta clase define una paleta de colores y gradientes que se utilizan en la aplicación.
///
/// Contiene colores estáticos que representan diferentes estados, temas y elementos visuales
/// específicos de la aplicación.
class AppColors {
  ///Theme
  static const Color primary = Color(0xFF36C8F6);
  static const Color primaryContrast95 = Color(0xFFD5E8FA);
  static const Color primaryContrast90 = Color(0xFFEDF4FA);

  static const Color secondary = Color(0xFF1F3799);

  static const Color tertiary = Color(0xFF24955D);
  static const Color tertiaryDark = Color(0xFF121129);

  ///Gradient
  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFF08EB8A),
      Color(0xFFF52026),
      Color(0xFF2E7EE0),
      Color(0xFFF52026),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(0.6),
    stops: [0.2, 0.4, 0.6, 0.9],
  );
  static const LinearGradient pinGradient = LinearGradient(
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [.3, .8],
  );

  static const Color red = Color(0xFFFF3B3B);
  static const Color lightRed = Color(0xFFB13030);
  static const Color darkRed = Color(0xFFF30001);

  static const Color blue = Color(0xFF0688FF);
  static const Color lightBlue = Color(0xFF00C8FF);
  static const Color darkBlue = Color(0xFF0033BF);

  static const Color green = Color(0xFF00DB73);
  static const Color lightGreen = Color(0xFF24955D);
  static const Color darkGreen = Color(0xFF009837);
  static const Color greenContrast = Color(0xFF474747);
  static const Color whiteContrast = Color(0xFF1D7F4E);

  ///AfinClic
  static const Color afinClicPrimary = Color(0xFF0074E6);
  static const Color afinClicLightPrimary = Color(0xFFD5E8FA);
  static const Color afinClicBrightPrimary = Color(0xFFEDF4FA);
  static const Color afinClicSecondary = Color(0xFF1F3799);

  ///Status
  static const Color error = Color(0xFFB3261E);
  static const Color minus = Color(0xFFD54413);
  static const Color plus = Color(0xFF238753);

  ///Neutral
  static const Color neutral100 = Color(0xFFFFFFFF);
  static const Color neutral97 = Color(0xFFF7F7F7);
  static const Color neutral95 = Color(0xFFF2F2F2);
  static const Color neutral90 = Color(0xFFE6E6E6);
  static const Color neutral80 = Color(0xFFCCCCCC);
  static const Color neutral50 = Color(0xFF828282);
  static const Color neutral30 = Color(0xFF4D4D4D);
  static const Color neutral0 = Color(0xFF000000);

  ///State To dark primary
  static const Color hoverPrimary8 = Color.fromRGBO(0, 116, 230, 0.08);
  static const Color focusAndPessedPrimary12 =
      Color.fromRGBO(0, 116, 230, 0.12);
  static const Color dragPrimary16 = Color.fromRGBO(0, 116, 230, 0.16);

  ///State To light
  static const Color hoverWhite8 = Color.fromRGBO(255, 255, 255, 0.08);
  static const Color focusAndPressedWhite12 =
      Color.fromRGBO(255, 255, 255, 0.12);
  static const Color dragWhite16 = Color.fromRGBO(255, 255, 255, 0.16);
}
