import 'package:flutter/material.dart';
import 'package:moloch_app/l10n/app_localizations.dart';

enum YesOrNot {
  yes(value: true),
  not(value: false);

  final bool value;

  const YesOrNot({
    required this.value,
  });

  String label(BuildContext context) {
    switch (this) {
      case YesOrNot.yes:
        return AppLocalizations.of(context).yes;
      case YesOrNot.not:
        return AppLocalizations.of(context).no;
    }
  }
}
