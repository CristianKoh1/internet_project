import 'package:flutter/material.dart';

/// Extension de tema que define una serie de colores personalizados para la aplicación.
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? primary;
  final Color? primaryContrast95;
  final Color? primaryContrast90;
  final Color? secondary;
  final Color? tertiary;
  final Color? tertiaryDark;
  final LinearGradient? gradient;
  final LinearGradient? pinGradient;
  final Color? red;
  final Color? lightRed;
  final Color? darkRed;
  final Color? blue;
  final Color? lightBlue;
  final Color? darkBlue;
  final Color? green;
  final Color? lightGreen;
  final Color? darkGreen;
  final Color? greenContrast;
  final Color? whiteContrast;
  final Color? afinClicPrimary;
  final Color? afinClicLightPrimary;
  final Color? afinClicBrightPrimary;
  final Color? afinClicSecondary;
  final Color? error;
  final Color? minus;
  final Color? plus;
  final Color? neutral100;
  final Color? neutral97;
  final Color? neutral95;
  final Color? neutral90;
  final Color? neutral80;
  final Color? neutral50;
  final Color? neutral30;
  final Color? neutral0;
  final Color? hoverPrimary8;
  final Color? focusAndPessedPrimary12;
  final Color? dragPrimary16;
  final Color? hoverWhite8;
  final Color? focusAndPressedWhite12;
  final Color? dragWhite16;

  const CustomColors({
    required this.primary,
    required this.primaryContrast95,
    required this.primaryContrast90,
    required this.secondary,
    required this.tertiary,
    required this.tertiaryDark,
    required this.gradient,
    required this.pinGradient,
    required this.red,
    required this.lightRed,
    required this.darkRed,
    required this.blue,
    required this.lightBlue,
    required this.darkBlue,
    required this.green,
    required this.lightGreen,
    required this.darkGreen,
    required this.greenContrast,
    required this.whiteContrast,
    required this.afinClicPrimary,
    required this.afinClicLightPrimary,
    required this.afinClicBrightPrimary,
    required this.afinClicSecondary,
    required this.error,
    required this.minus,
    required this.plus,
    required this.neutral100,
    required this.neutral97,
    required this.neutral95,
    required this.neutral90,
    required this.neutral80,
    required this.neutral50,
    required this.neutral30,
    required this.neutral0,
    required this.hoverPrimary8,
    required this.focusAndPessedPrimary12,
    required this.dragPrimary16,
    required this.hoverWhite8,
    required this.focusAndPressedWhite12,
    required this.dragWhite16,
  });

  @override
  CustomColors copyWith({
    Color? primary,
    Color? lightPrimary,
    Color? brightPrimary,
    Color? secondary,
    Color? tertiary,
    Color? accent,
    Color? error,
    Color? minus,
    Color? plus,
    Color? neutral100,
    Color? neutral97,
    Color? neutral95,
    Color? neutral90,
    Color? neutral80,
    Color? neutral50,
    Color? neutral30,
    Color? neutral0,
    Color? hoverPrimary8,
    Color? focusPressedPrimary12,
    Color? dragPrimary16,
    Color? hoverWhite8,
    Color? focusPressedWhite12,
    Color? dragWhite16
  }) {
    return CustomColors(
      primary: primary ?? this.primary,
      primaryContrast95: primaryContrast95 ?? this.primaryContrast95,
      primaryContrast90: primaryContrast90 ?? this.primaryContrast90,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      tertiaryDark: tertiaryDark ?? this.tertiaryDark,
      gradient: gradient ?? this.gradient,
      pinGradient: pinGradient ?? this.pinGradient,
      red: red ?? this.red,
      lightRed: lightRed ?? this.lightRed,
      darkRed: darkRed ?? this.darkRed,
      blue: blue ?? this.blue,
      lightBlue: lightBlue ?? this.lightBlue,
      darkBlue: darkBlue ?? this.darkBlue,
      green: green ?? this.green,
      lightGreen: lightGreen ?? this.lightGreen,
      darkGreen: darkGreen ?? this.darkGreen,
      greenContrast: greenContrast ?? this.greenContrast,
      whiteContrast: whiteContrast ?? this.whiteContrast,
      afinClicPrimary: afinClicPrimary ?? this.afinClicPrimary,
      afinClicLightPrimary: afinClicLightPrimary ?? this.afinClicLightPrimary,
      afinClicBrightPrimary:
          afinClicBrightPrimary ?? this.afinClicBrightPrimary,
      afinClicSecondary: afinClicSecondary ?? this.afinClicSecondary,
      error: error ?? this.error,
      minus: minus ?? this.minus,
      plus: plus ?? this.plus,
      neutral100: neutral100 ?? this.neutral100,
      neutral97: neutral97 ?? this.neutral97,
      neutral95: neutral95 ?? this.neutral95,
      neutral90: neutral90 ?? this.neutral90,
      neutral80: neutral80 ?? this.neutral80,
      neutral50: neutral50 ?? this.neutral50,
      neutral30: neutral30 ?? this.neutral30,
      neutral0: neutral0 ?? this.neutral0,
      hoverPrimary8: hoverPrimary8 ?? this.hoverPrimary8,
      focusAndPessedPrimary12:
          focusAndPessedPrimary12 ?? this.focusAndPessedPrimary12,
      dragPrimary16: dragPrimary16 ?? this.dragPrimary16,
      hoverWhite8: hoverWhite8 ?? this.hoverWhite8,
      focusAndPressedWhite12:
          focusAndPressedWhite12 ?? this.focusAndPressedWhite12,
      dragWhite16: dragWhite16 ?? this.dragWhite16,
    );
  }

  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      primary: Color.lerp(primary, other.primary, t),
      primaryContrast95:
          Color.lerp(primaryContrast95, other.primaryContrast95, t),
      primaryContrast90:
          Color.lerp(primaryContrast90, other.primaryContrast90, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      tertiary: Color.lerp(tertiary, other.tertiary, t),
      tertiaryDark: Color.lerp(tertiaryDark, other.tertiaryDark, t),
      gradient: LinearGradient.lerp(gradient, other.gradient, t),
      pinGradient: LinearGradient.lerp(pinGradient, other.pinGradient, t),
      red: Color.lerp(red, other.red, t),
      lightRed: Color.lerp(lightRed, other.lightRed, t),
      darkRed: Color.lerp(darkRed, other.darkRed, t),
      blue: Color.lerp(blue, other.blue, t),
      lightBlue: Color.lerp(lightBlue, other.lightBlue, t),
      darkBlue: Color.lerp(darkBlue, other.darkBlue, t),
      green: Color.lerp(green, other.green, t),
      lightGreen: Color.lerp(lightGreen, other.lightGreen, t),
      darkGreen: Color.lerp(darkGreen, other.darkGreen, t),
      greenContrast:
          Color.lerp(greenContrast, other.greenContrast, t),
      whiteContrast: Color.lerp(whiteContrast, other.whiteContrast, t),
      afinClicPrimary: Color.lerp(afinClicPrimary, other.afinClicPrimary, t),
      afinClicLightPrimary:
          Color.lerp(afinClicLightPrimary, other.afinClicLightPrimary, t),
      afinClicBrightPrimary:
          Color.lerp(afinClicBrightPrimary, other.afinClicBrightPrimary, t),
      afinClicSecondary:
          Color.lerp(afinClicSecondary, other.afinClicSecondary, t),
      error: Color.lerp(error, other.error, t),
      minus: Color.lerp(minus, other.minus, t),
      plus: Color.lerp(plus, other.plus, t),
      neutral100: Color.lerp(neutral100, other.neutral100, t),
      neutral97: Color.lerp(neutral97, other.neutral97, t),
      neutral95: Color.lerp(neutral95, other.neutral95, t),
      neutral90: Color.lerp(neutral90, other.neutral90, t),
      neutral80: Color.lerp(neutral80, other.neutral80, t),
      neutral50: Color.lerp(neutral50, other.neutral50, t),
      neutral30: Color.lerp(neutral30, other.neutral30, t),
      neutral0: Color.lerp(neutral0, other.neutral0, t),
      hoverPrimary8: Color.lerp(hoverPrimary8, other.hoverPrimary8, t),
      focusAndPessedPrimary12:
          Color.lerp(focusAndPessedPrimary12, other.focusAndPessedPrimary12, t),
      dragPrimary16: Color.lerp(dragPrimary16, other.dragPrimary16, t),
      hoverWhite8: Color.lerp(hoverWhite8, other.hoverWhite8, t),
      focusAndPressedWhite12:
          Color.lerp(focusAndPressedWhite12, other.focusAndPressedWhite12, t),
      dragWhite16: dragWhite16,
    );
  }

  // Optional
  @override
  String toString() => 'CustomColors(primary: $primary)';
}
