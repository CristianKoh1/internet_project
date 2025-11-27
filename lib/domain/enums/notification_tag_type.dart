import 'package:flutter/material.dart';

enum NotificationTagType {
  loanApplication(value: "SOLICITUD_PRESTAMO", icon:Icons.layers_rounded),
  success(value: "SUCCESS", icon:Icons.check);


  final String value;
  final IconData icon;

  const NotificationTagType({
    required this.value,
    required this.icon,
  });
}