import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/pages/auth/sign_up/widgets/widgets.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive_layout.dart';
import 'package:moloch_app/presentation/widget/custom/custom_button.dart';
import 'package:moloch_app/presentation/widget/custom/custom_logo.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/theme/extension.dart';

@RoutePage()
class NoClientPage extends StatelessWidget {
  const NoClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>())],
      child: ResponsiveLayout(
        mobile: Scaffold(
          body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomLogo(black: true)),
            SignUpWidgets().noClientBody(context: context),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: false,
              child: Column(
                children: [
                  Expanded(child: Center(
                    child: CustomPadding(
                      child: Text(
                        AppLocalizations.of(context).noClientMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                         fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )),
                  Expanded(child: SizedBox()),
                  SignUpWidgets().buttonsConfirmInfo(context: context),
                ],
              ),
            ),
          ],
        )/* CustomPadding(
            child: Stack(
              children: [
                Center(
                  child: Text(
                    AppLocalizations.of(context).noClientMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: AppLocalizations.of(context).goBack,
                      onPressed: () {
                        AutoRouter.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ), */
        ),
      ),
    );
  }
}
