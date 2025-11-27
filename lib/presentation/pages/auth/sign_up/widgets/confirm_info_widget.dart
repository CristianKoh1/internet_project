import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/pages/auth/sign_up/widgets/widgets.dart';
import 'package:moloch_app/presentation/widget/custom/custom_check_widget.dart';
import 'package:moloch_app/presentation/widget/custom/custom_logo.dart';

class ConfirmInfoWidget extends StatelessWidget {
  final bool isSignUp;
  const ConfirmInfoWidget({super.key,this.isSignUp = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomLogo(black: true)),
            SignUpWidgets().confirmInfoBody(context: context),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: false,
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  _checkbox(),
                  SignUpWidgets().buttonsConfirmInfo(context: context,isSignUp: isSignUp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkbox() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return CustomCheckWidget(
          enable: state.termsAccepted.getOrElse(() => false),
          firstText: AppLocalizations.of(context).validInfoCheck,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              context.read<AuthBloc>().add(
                AuthEvent.changeTermsAccepted(value: newValue),
              );
            }
          },
        );
      },
    );
  }
}
