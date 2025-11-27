import 'package:moloch_app/theme/app_colors.dart';
import 'package:moloch_app/theme/extension.dart';
import 'package:flutter/material.dart';

/// Esta clase define los temas claros y oscuros para la aplicación.
///
/// Contiene configuraciones para colores, tipografías, temas de botones, temas de texto,
/// temas de app bar, temas de decoración de entrada, temas de tarjeta, temas de icono y temas de checkbox.
class ThemeClass {
   /// La fuente principal utilizada en la aplicación.
  static const String primaryFont = 'Alexandria';
    /// La fuente secundaria utilizada en la aplicación.
  static const String secondaryFont = 'Alexandria';

  /// El tema claro de la aplicación.
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.neutral100,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColors.primary,
          width: 2.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
    extensions: const <ThemeExtension>[
      CustomColors(
        primary: AppColors.primary,
        primaryContrast95: AppColors.primaryContrast95,
        primaryContrast90: AppColors.primaryContrast90,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        tertiaryDark: AppColors.tertiaryDark,
        gradient: AppColors.gradient,
        pinGradient: AppColors.pinGradient,
        red: AppColors.red,
        lightRed: AppColors.lightRed,
        darkRed: AppColors.darkRed,
        blue: AppColors.blue,
        lightBlue: AppColors.lightBlue,
        darkBlue: AppColors.darkBlue,
        green: AppColors.green,
        lightGreen: AppColors.lightGreen,
        darkGreen: AppColors.darkGreen,
        greenContrast: AppColors.greenContrast,
        whiteContrast: AppColors.whiteContrast,
        afinClicPrimary: AppColors.afinClicPrimary,
        afinClicLightPrimary: AppColors.afinClicLightPrimary,
        afinClicBrightPrimary: AppColors.afinClicBrightPrimary,
        afinClicSecondary: AppColors.afinClicSecondary,
        error: AppColors.error,
        minus: AppColors.minus,
        plus: AppColors.plus,
        neutral100: AppColors.neutral100,
        neutral97: AppColors.neutral97,
        neutral95: AppColors.neutral95,
        neutral90: AppColors.neutral90,
        neutral80: AppColors.neutral80,
        neutral50: AppColors.neutral50,
        neutral30: AppColors.neutral30,
        neutral0: AppColors.neutral0,
        hoverPrimary8: AppColors.hoverPrimary8,
        focusAndPessedPrimary12: AppColors.focusAndPessedPrimary12,
        dragPrimary16: AppColors.dragPrimary16,
        hoverWhite8: AppColors.hoverWhite8,
        focusAndPressedWhite12: AppColors.focusAndPressedWhite12,
        dragWhite16: AppColors.dragWhite16,
      )
    ],
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 28.5,
        color: AppColors.neutral0,
      ),
      displayMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 24.5,
        color: AppColors.neutral0,
      ),
      displaySmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 23.5,
        color: AppColors.neutral0,
      ),
      headlineLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 22.5,
        color: AppColors.neutral0,
      ),
      headlineMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 21.5,
        color: AppColors.neutral0,
      ),
      headlineSmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 20.5,
        color: AppColors.neutral0,
      ),
      titleLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 19.5,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral0,
      ),
      titleMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 18.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      titleSmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 17.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      labelLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 16.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      labelMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 15.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      labelSmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      bodyLarge: TextStyle(
        fontFamily: secondaryFont,
        fontSize: 13.5,
        color: AppColors.neutral0,
      ),
      bodyMedium: TextStyle(
        fontFamily: secondaryFont,
        fontSize: 12.5,
        color: AppColors.neutral0,
      ),
      bodySmall: TextStyle(
        fontFamily: secondaryFont,
        fontSize: 11.5,
        color: AppColors.neutral0,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.neutral100,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF4D4D4D),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.neutral100,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: AppColors.neutral80,
          width: 1.0,
        ),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.neutral0),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.secondary;
          }
          return AppColors.neutral100;
        },
      ),
    ),
  );

  /// El tema oscuro de la aplicación.
  static ThemeData darkTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.neutral100,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primary, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
    extensions: const <ThemeExtension>[
      CustomColors(
        primary: AppColors.primary,
        primaryContrast95: AppColors.primaryContrast95,
        primaryContrast90: AppColors.primaryContrast90,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        tertiaryDark: AppColors.tertiaryDark,
        gradient: AppColors.gradient,
        pinGradient: AppColors.pinGradient,
        red: AppColors.red,
        lightRed: AppColors.lightRed,
        darkRed: AppColors.darkRed,
        blue: AppColors.blue,
        lightBlue: AppColors.lightBlue,
        darkBlue: AppColors.darkBlue,
        green: AppColors.green,
        lightGreen: AppColors.lightGreen,
        darkGreen: AppColors.darkGreen,
        greenContrast: AppColors.greenContrast,
        whiteContrast: AppColors.whiteContrast,
        afinClicPrimary: AppColors.afinClicPrimary,
        afinClicLightPrimary: AppColors.afinClicLightPrimary,
        afinClicBrightPrimary: AppColors.afinClicBrightPrimary,
        afinClicSecondary: AppColors.afinClicSecondary,
        error: AppColors.error,
        minus: AppColors.minus,
        plus: AppColors.plus,
        neutral100: AppColors.neutral100,
        neutral97: AppColors.neutral97,
        neutral95: AppColors.neutral95,
        neutral90: AppColors.neutral90,
        neutral80: AppColors.neutral80,
        neutral50: AppColors.neutral50,
        neutral30: AppColors.neutral30,
        neutral0: AppColors.neutral0,
        hoverPrimary8: AppColors.hoverPrimary8,
        focusAndPessedPrimary12: AppColors.focusAndPessedPrimary12,
        dragPrimary16: AppColors.dragPrimary16,
        hoverWhite8: AppColors.hoverWhite8,
        focusAndPressedWhite12: AppColors.focusAndPressedWhite12,
        dragWhite16: AppColors.dragWhite16,
      )
    ],
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 25.5,
        color: AppColors.neutral0,
      ),
      displayMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 24.5,
        color: AppColors.neutral0,
      ),
      displaySmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 23.5,
        color: AppColors.neutral0,
      ),
      headlineLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 22.5,
        color: AppColors.neutral0,
      ),
      headlineMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 21.5,
        color: AppColors.neutral0,
      ),
      headlineSmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 20.5,
        color: AppColors.neutral0,
      ),
      titleLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 19.5,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral0,
      ),
      titleMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 18.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      titleSmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 17.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      labelLarge: TextStyle(
        fontFamily: primaryFont,
        fontSize: 16.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      labelMedium: TextStyle(
        fontFamily: primaryFont,
        fontSize: 15.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      labelSmall: TextStyle(
        fontFamily: primaryFont,
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral0,
      ),
      bodyLarge: TextStyle(
        fontFamily: secondaryFont,
        fontSize: 13.5,
        color: AppColors.neutral0,
      ),
      bodyMedium: TextStyle(
        fontFamily: secondaryFont,
        fontSize: 12.5,
        color: AppColors.neutral0,
      ),
      bodySmall: TextStyle(
        fontFamily: secondaryFont,
        fontSize: 11.5,
        color: AppColors.neutral0,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.neutral100,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF4D4D4D),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.neutral100,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: AppColors.neutral80,
          width: 1.0,
        ),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.neutral100),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.secondary;
          }
          return AppColors.neutral100;
        },
      ),
    ),
  );
}
