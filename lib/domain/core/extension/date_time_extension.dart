import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  ///Devuelve la fecha de UTC a foramto local.
  ///
  ///Ejemplo: 15 enero 2024, 05:35 p.m.
  ///
  ///El parametro format puede ser como se muestra aquí
  ///https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  String dateToLocal({
    required BuildContext context,
    String format = 'd MMMM y, hh:mm a',
  }) {
    final locale = Localizations.localeOf(context);
    final dateFormat = DateFormat(format, locale.languageCode);
    return dateFormat.format(this);
  }
}
