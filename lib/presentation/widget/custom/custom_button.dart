import 'package:moloch_app/presentation/utils/responsive/responsive.dart';
import 'package:moloch_app/theme/app_colors.dart';
import 'package:moloch_app/theme/extension.dart';
import 'package:flutter/material.dart';



enum CustomButtonType { primary, secondary, text, tertiary }

class CustomButton extends StatelessWidget {
  final CustomButtonType type;
  final String text;
  final bool icon;
  final bool enable;
  final bool expanded;
  final bool appBar;
  final IconData? remplaceIcon;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    this.type = CustomButtonType.primary,
    required this.text,
    this.icon = false,
    this.enable = true,
    required this.onPressed,
    this.expanded = true,
    this.appBar = false,
    this.remplaceIcon,
  });

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    final primary = Theme.of(context).extension<CustomColors>()?.primary ??
        AppColors.primary;
    final secondary = Theme.of(context).extension<CustomColors>()?.secondary ??
        AppColors.secondary;
    final Color neutral =
        Theme.of(context).extension<CustomColors>()?.neutral100 ??
            AppColors.neutral100;
    final Color black = Theme.of(context).extension<CustomColors>()?.neutral0 ??
        AppColors.neutral0;

    Color textColor = neutral;
    Color backgroundColor = black;
    BorderSide side = BorderSide.none;
    double? elevation;
    Color? surfaceTintColor;
    Color? foregroundColor;

    if (type == CustomButtonType.secondary) {
      textColor = neutral;
      backgroundColor = primary;
      side = BorderSide(color: primary, width: 2);
      surfaceTintColor = AppColors.hoverPrimary8;
      foregroundColor = AppColors.hoverPrimary8;
    }
    if (type == CustomButtonType.primary) {
      textColor = neutral;
      backgroundColor = black;
      side = BorderSide(color: black, width: 2);
      surfaceTintColor = AppColors.hoverPrimary8;
      foregroundColor = AppColors.hoverPrimary8;
    }

    if (type == CustomButtonType.text) {
      textColor = neutral;
      backgroundColor = Colors.transparent;
      elevation = 0;
    }

    if (type == CustomButtonType.tertiary) {
      textColor = secondary;
      backgroundColor = AppColors.lightBlue;
      elevation = 0;
    }

    if (!enable) {
      elevation = 0;
      backgroundColor = (type == CustomButtonType.primary? black:AppColors.focusAndPessedPrimary12);
      textColor =  (type == CustomButtonType.primary? neutral:black);
    }

    return Opacity(
      opacity: enable ? 1 : .38,
      child: AbsorbPointer(
        absorbing: !enable,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: responsive.hp(5)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              surfaceTintColor: surfaceTintColor,
              foregroundColor: foregroundColor,
              side: side,
              elevation: elevation,
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              /* final _routerName = AutoRouter.of(context).current.name;
              final _analytics = getIt<IFirebaseAnalyticsRepository>();
              final _buttonType = type.name;

              final PushButtonEventModel event = PushButtonEventModel(
                routerName: _routerName,
                buttonType: _buttonType,
              );

              _analytics.pushButton(event); */
              onPressed?.call();
            },
            child: Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appBar
                    ? _buttonBody(textColor, context)
                    : Expanded(
                        child: _buttonBody(textColor, context),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buttonBody(Color textColor, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getIcon(
          icon: icon,
          color: textColor,
        ),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: textColor,
                ),
          ),
        ),
      ],
    );
  }

  Widget getIcon({required bool icon, required Color color}) {
    if (!icon) return const SizedBox();

    return Row(
      children: [
        Icon(
          remplaceIcon ?? Icons.add,
          color: color,
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
