import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/pages/auth/login/widgets/widgets.dart';
import 'package:moloch_app/presentation/widget/custom/custom_button.dart';
import 'package:moloch_app/presentation/widget/custom/custom_logo.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:moloch_app/theme/extension.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0DA9FF),
              Color(0xFFFFFFFF),
            ], // Colores especificados
            begin: Alignment.topCenter,
            stops: [0.0, 0.5],
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: CustomPadding(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomLogo(black: false),
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomPadding(
                      bottom: 0,
                      top: 0,
                      child: Text(
                        'Bienvenido',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Text(
                  'INTERNET \nILIMITADO',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).extension<CustomColors>()?.primary,
                  ),
                ),
                Expanded(child: SizedBox()),
                CustomButton(
                  text: AppLocalizations.of(context).login,
                  type: CustomButtonType.secondary,
                  onPressed: () {
                    AutoRouter.of(context).push(LoginPasswordRoute());
                  },
                ),
                LoginWidgets().createAccount(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


