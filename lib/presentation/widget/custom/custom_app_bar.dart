import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/theme/extension.dart';

enum CustomAppBarType { smallCentered, small, medium, large, register }

enum AfinClicElevationType { fat, onScroll }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final CustomAppBarType type;
  final List<Widget>? actions;
  final bool leading;
  final bool logoWhite;
  final bool showLogo;
  final void Function()? leadingFunction;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.logoWhite = false,
    this.type = CustomAppBarType.medium,
    this.actions,
    this.leading = true,
    this.leadingFunction,
    this.showLogo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Theme.of(context).extension<CustomColors>()?.primary,
      toolbarHeight: _getHeight(),
      leading: leading ? _leading(context) : Container(),
      automaticallyImplyLeading: leading,
      title: _getTitle(context),
      actions: actions,
      centerTitle: type == CustomAppBarType.smallCentered,
      bottom: _getBottom(context),
    );
  }

  PreferredSize? _getBottom(BuildContext context) {
    if (type == CustomAppBarType.medium || type == CustomAppBarType.large) {
      return PreferredSize(
        preferredSize: const Size(100, 200),
        child: CustomPadding(
          horizontalOnly: true,
          child: Container(
            padding: EdgeInsets.only(
              top: type == CustomAppBarType.medium ? 0 : 40,
              bottom: type == CustomAppBarType.medium ? 20 : 20,
            ),
            alignment: Alignment.topLeft,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: type == CustomAppBarType.medium
                  ? Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context)
                            .extension<CustomColors>()
                            ?.neutral0,
                      )
                  : Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context)
                            .extension<CustomColors>()
                            ?.neutral0,
                      ),
            ),
          ),
        ),
      );
    }
    return null;
  }

  Padding _leading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: type == CustomAppBarType.register ? 8 : 0,
        top: 8,
      ),
      child: BackButton(
        onPressed: leadingFunction,
        style: ButtonStyle(
          iconSize: WidgetStateProperty.all(30),
          fixedSize: WidgetStateProperty.all(const Size(0, 0)),
        ),
        color: logoWhite
            ? Theme.of(context).extension<CustomColors>()?.neutral100
            : Theme.of(context).extension<CustomColors>()?.primary,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_getHeight());

  Widget? _getTitle(BuildContext context) {
    if (type == CustomAppBarType.smallCentered ||
        type == CustomAppBarType.small) {
      final text = Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).extension<CustomColors>()?.neutral0,
            ),
      );
      if (showLogo) {
        return Row(
          children: [
            text,
            Spacer(),
            SvgPicture.asset(
              'assets/logo/logo.png',
              height: 24,
            ),
            Spacer(),
          ],
        );
      }
      return text;
    } else if (type == CustomAppBarType.register) {
      return SvgPicture.asset(
        'assets/logo/logo.png',
        height: 24,
      );
    }
    return null;
  }

  double _getHeight() {
    switch (type) {
      case CustomAppBarType.smallCentered:
      case CustomAppBarType.small:
      case CustomAppBarType.register:
        return 60;
      case CustomAppBarType.medium:
        return 132;
      case CustomAppBarType.large:
        return 145;
      default:
        return 145;
    }
  }
}
