import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum CustomLogoType { appBar, logo, pinLogo, banner }

enum CustomLogoPosition { vertical, horizontal }

class CustomLogo extends StatelessWidget {
  final CustomLogoType type;
  final bool black;
  final CustomLogoPosition position;
  final MainAxisAlignment mainAxisAlignment;

  const CustomLogo({
    Key? key,
    this.type = CustomLogoType.logo,
    this.black = true,
    this.position = CustomLogoPosition.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70,bottom: 30),
      child: _logo(width: 100, height: 70),
    );
  }

  Widget _logo({required double width, required double height}) {
    final color = black ? 'black': 'white';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Flexible(
          child: SvgPicture.asset(
            'assets/logo/moloch_$color.svg',
            width: width,
            height: height,
          ),
        ),
      ],
    );
  }
}
