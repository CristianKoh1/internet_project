import 'package:moloch_app/config/enviroment.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DecimalExtension on Decimal? { 
  static final int _oneHundred = 100;
  ///Devuelve los decimales en formato de moneda del país con solamente dos decimales y con la divisa Mexicana.
  ///
  ///
  ///Ejemplo: $2,345.00 USD
  ///
  ///El parametro format puede ser como se muestra aquí:
  ///https://pub.dev/documentation/intl/latest/intl/NumberFormat-class.html
  ///
  ///El parametro divisa puede eliminar la abreviacon de la divisa Mexiacana cuando es false.
  ///
  ///El resultado que devuelve es el siguiente: $2,345.00
  ///
  String decimalToLocal({
    required BuildContext context,
    String format = '###,##0.00',
    bool divisa = true,
  }) {
    final numberFormat = NumberFormat(format, 'en_US');
    final decimal = this;

    if (decimal == null) return '';

    return divisa == true
        ? '${Enviroments.moneySymbol}${numberFormat.format(
            num.parse(decimal.toString()),
          )} USD'
        : '${Enviroments.moneySymbol}${numberFormat.format(
            num.parse(decimal.toString()),
          )}';
  }

   String decimalToPercentage() {
    final decimal = this;

    if (decimal == null) return '';

    return '${decimal* Decimal.fromInt(_oneHundred)}%';
  }

   Decimal convertDecimalToPercentage() {
    final decimal = this;

    if (decimal == null) return Decimal.zero;

    return decimal* Decimal.fromInt(_oneHundred);
  }
}
