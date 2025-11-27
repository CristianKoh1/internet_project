import 'package:flutter/material.dart';
import 'package:moloch_app/theme/app_colors.dart';
import 'package:moloch_app/theme/extension.dart';

enum CustomSnackBarType { error, success }

class CustomSnackBar extends StatelessWidget {
  final CustomSnackBarType type;
  final String message;
  final Color? textColor;
  final Duration? duration;

  const CustomSnackBar({
    super.key,
    required this.type,
    required this.message,
    this.textColor,
    this.duration,
  });

  SnackBar createSnackBar(BuildContext context) {
    Color successColor =
        Theme.of(context).extension<CustomColors>()?.plus ?? AppColors.plus;
    Color errorColor =
        Theme.of(context).extension<CustomColors>()?.neutral0 ?? AppColors.neutral0;

    return type == CustomSnackBarType.success
        ? _customSnackBar(context, successColor)
        : _customSnackBar(context, errorColor);
  }

  SnackBar _customSnackBar(
    BuildContext context,
    Color backgroundColor,
  ) {
    return SnackBar(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration ?? const Duration(seconds: 4),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor ??
                  Theme.of(context).extension<CustomColors>()?.neutral100,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
