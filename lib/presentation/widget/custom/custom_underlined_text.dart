import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moloch_app/theme/extension.dart';

class CustomUnderlinedText extends StatelessWidget {
  final bool bodySmall;
  final String firstText;
  final String firstTextUnderlined;
  final String secondText;
  final String secondTextUnderlined;
  final String thirdText;
  final Function()? firstOnTap;
  final Function()? secondOnTap;
  final bool cancelSecondUnderlined;
  final bool cancelFirstUnderlined;

  const CustomUnderlinedText({
    super.key,
    this.bodySmall = true,
    required this.firstText,
    required this.firstTextUnderlined,
    this.secondText = '',
    this.secondTextUnderlined = '',
    this.thirdText = '',
    this.firstOnTap,
    this.secondOnTap,
    this.cancelSecondUnderlined = false,
    this.cancelFirstUnderlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: _style(context, false, true, false),
        children: <TextSpan>[
          _underlinedText(
            context,
            firstTextUnderlined,
            firstOnTap,
            cancelUnderlined: cancelFirstUnderlined,
          ),
          if (secondText != '') _text(context, secondText),
          if (secondTextUnderlined != '')
            _underlinedText(
              context,
              secondTextUnderlined,
              secondOnTap,
              cancelUnderlined: cancelSecondUnderlined,
            ),
          if (thirdText != '') _text(context, thirdText),
        ],
      ),
    );
  }

  TextSpan _text(
    BuildContext context,
    String text,
  ) {
    return TextSpan(
      text: text,
      style: _style(context, false, true, false),
    );
  }

  TextSpan _underlinedText(
    BuildContext context,
    String text,
    Function()? onTap, {
    bool cancelUnderlined = false,
    bool bold = true,
  }) {
    return TextSpan(
      text: text,
      style: _style(context, !cancelUnderlined, false, bold),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }

  TextStyle? _style(
    BuildContext context,
    bool underline,
    bool neutral30,
    bool bold,
  ) {
    return bodySmall
        ? Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: bold ? FontWeight.w600 : null,
              decoration: underline ? TextDecoration.underline : null,
              color: neutral30
                  ? Theme.of(context).extension<CustomColors>()?.neutral30
                  : Theme.of(context).extension<CustomColors>()?.primary,
            )
        : Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: bold ? FontWeight.w600 : null,
              decoration: underline ? TextDecoration.underline : null,
              color: neutral30
                  ? Theme.of(context).extension<CustomColors>()?.neutral30
                  : Theme.of(context).extension<CustomColors>()?.primary,
            );
  }
}
