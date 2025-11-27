import 'package:flutter/material.dart';
import 'package:moloch_app/domain/core/enums/custom_padding_type.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive.dart';

class CustomPadding extends StatelessWidget {
  final bool sliver;
  final bool horizontalOnly;
  final Widget child;
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  final CustomPaddingType? type;

  const CustomPadding({
    super.key,
    required this.child,
    this.top = 10,
    this.bottom = 10,
    this.right = 16,
    this.left = 16,
    this.horizontalOnly = false,
    this.sliver = false,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    double paddingTop = top ?? 10;
    double paddingBottom = bottom ?? 10;
    double paddingRight = right ?? 16;
    double paddingLeft = left ?? 16;

    if (type != null) {
      final responsive = Responsive(context);
      paddingLeft = responsive.wp(type!.left);
      paddingRight = responsive.wp(type!.right);
      paddingBottom = responsive.wp(type!.bottom);
      paddingTop = responsive.wp(type!.top);
    }

    if (sliver) {
      return SliverPadding(
        padding: EdgeInsets.only(
          top: horizontalOnly ? 0 : paddingTop,
          bottom: horizontalOnly ? 0 : paddingBottom,
          right: paddingRight,
          left: paddingLeft,
        ),
        sliver: child,
      );
    }
    return Padding(
      padding: EdgeInsets.only(
        top: horizontalOnly ? 0 : paddingTop,
        bottom: horizontalOnly ? 0 : paddingBottom,
        right: paddingRight,
        left: paddingLeft,
      ),
      child: child,
    );
  }
}
