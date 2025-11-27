import 'package:flutter/material.dart';
import 'package:moloch_app/presentation/widget/custom/custom_underlined_text.dart';
import 'package:moloch_app/theme/extension.dart';

class CustomCheckWidget extends StatelessWidget {
  final bool enable;
  final bool underline;
  final String firstText;
  final String firstUnderline;
  final Function()? firstOnTap;
  final bool cancelFirstUnderlined;
  final String secondText;
  final String secondUnderline;
  final Function()? secondOnTap;
  final bool cancelSecondUnderlined;
  final String thirdText;
  final Function(bool?)? onChanged;

  const CustomCheckWidget({
    Key? key,
    required this.enable,
    this.underline = false,
    required this.firstText,
    this.firstUnderline = '',
    this.firstOnTap,
    this.cancelFirstUnderlined = false,
    this.secondText = '',
    this.secondUnderline = '',
    this.secondOnTap,
    this.cancelSecondUnderlined = false,
    this.thirdText = '',
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              activeColor: Theme.of(context).extension<CustomColors>()?.primary,
              value: enable,
              onChanged: onChanged,
            ),
            Expanded(
              child: underline ? _underlineText() : _text(context),
            ),
          ],
        ),
      ],
    );
  }

  Text _text(BuildContext context) {
    return Text(
      firstText,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).extension<CustomColors>()?.neutral30,
          ),
    );
  }

  CustomUnderlinedText _underlineText() {
    return CustomUnderlinedText(
      firstText: firstText,
      firstTextUnderlined: firstUnderline,
      firstOnTap: firstOnTap,
      secondText: secondText,
      secondTextUnderlined: secondUnderline,
      cancelSecondUnderlined: cancelSecondUnderlined,
      secondOnTap: secondOnTap,
      thirdText: thirdText,
      cancelFirstUnderlined: cancelFirstUnderlined,
    );
  }
}
