import 'package:flutter/material.dart';
import 'package:moloch_app/theme/extension.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      height: 100,
      width: 100,
      child: CircularProgressIndicator(
        color: Theme.of(context).extension<CustomColors>()?.primary,
        backgroundColor:
            Theme.of(context).extension<CustomColors>()?.neutral80,
        strokeWidth: 10,
      ),
    );
  }
}
