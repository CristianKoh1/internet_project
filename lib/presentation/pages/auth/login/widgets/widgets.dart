import 'package:auto_route/auto_route.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/domain/core/event/event_bus.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';
import 'package:moloch_app/domain/core/extension/option_object_value_extension.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/utils/responsive/dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_button.dart';
import 'package:moloch_app/presentation/widget/custom/custom_input.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/presentation/widget/custom/custom_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:moloch_app/theme/extension.dart';

class LoginWidgets {
  Widget loginButtons({
    required BuildContext context,
    required bool isAddAccount,
  }) {
    return CustomPadding(
      sliver: true,
      child: SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          children: [
            Expanded(child: SizedBox()),
            _buttonLogin(isAddAccount),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget loginWithPasswordButton({
    required BuildContext context,
    required bool isAddAccount,
    bool black = true
  }) {
    return CustomPadding(
      sliver: true,
      child: SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          mainAxisAlignment:
              kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.end,
          children: [
            _buttonLoginPassword(isAddAccount: isAddAccount),
            isAddAccount
                ? SizedBox(height: 20)
                : LoginWidgets().createAccount(context,black: black),
          ],
        ),
      ),
    );
  }

  CustomPadding loginWithPasswordbody({
    required BuildContext context,
    required bool isAddAccount,
  }) {
    final title =
        isAddAccount
            ? AppLocalizations.of(context).addAccount
            : AppLocalizations.of(context).helloAgain;
    return CustomPadding(
      sliver: true,
      child: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment:
              kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: kIsWeb,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).extension<CustomColors>()?.neutral50,
                ),
              ),
            ),
            _message(context),
            _phoneNumber(context,type: CustomInputType.molochSecundary),
            _inputPassword(context),
            _forgotPassword(context, isAddAccount: isAddAccount),
          ],
        ),
      ),
    );
  }

  Container createAccount(BuildContext context,{bool black = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: AppLocalizations.of(context).noAccountYet,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: black? Theme.of(context).extension<CustomColors>()?.neutral50:Theme.of(context).extension<CustomColors>()?.neutral100,
                ),
              ),
              TextSpan(
                text: ' ${AppLocalizations.of(context).createAccountHere}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: black? Theme.of(context).extension<CustomColors>()?.primary:Theme.of(context).extension<CustomColors>()?.neutral0,
                  fontWeight: FontWeight.bold,
                ),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        AutoRouter.of(context).push(SignUpRoute());
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomPadding loginBody({required BuildContext context,bool isAddAccount = false}) {
    return CustomPadding(
      sliver: true,
      child: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment:
              kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: kIsWeb,
              child: Text(
                AppLocalizations.of(context).helloAgain,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            _loginMessage(context,isAddAccount: isAddAccount),
            _phoneNumber(context,isAddAccount:  isAddAccount),
          ],
        ),
      ),
    );
  }

  CustomPadding loginWithPasswordBody({required BuildContext context}) {
    return CustomPadding(
      sliver: true,
      child: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment:
              kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: kIsWeb,
              child: Text(
                AppLocalizations.of(context).helloAgain,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            _message(context),
            _phoneNumber(context),
            _inputPassword(context),
            _forgotPassword(context),
          ],
        ),
      ),
    );
  }

  Widget _inputPassword(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    return CustomInput(
      type: CustomInputType.molochSecundary,
      keyboardType: CustomTextInputType.password,
      obscureText: true,
      labelText: AppLocalizations.of(context).password,
      initValue: authBloc.state.password.getValueOrElse(orElse: () => ''),
      onChanged: (text) {
        final AuthBloc authBloc = context.read<AuthBloc>();
        authBloc.add(AuthEvent.changePassword(password: text));
      },
      validator:
          (_) => authBloc.state.password.mapValidator(
            none: () => AppLocalizations.of(context).fillThisField,
            invalid: (l) => AppLocalizations.of(context).passwordIncorrect,
          ),
    );
  }

  Widget _message(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).enterAccount,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral100,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).init_with_password,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral100,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
  Widget _loginMessage(BuildContext context, {bool isAddAccount = false}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isAddAccount? AppLocalizations.of(context).addAccount : AppLocalizations.of(context).enterAccount,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral0,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isAddAccount? AppLocalizations.of(context).initWithFolio : AppLocalizations.of(context).init_with_password,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _phoneNumber(BuildContext context,{type = CustomInputType.enabled,bool isAddAccount = false}) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    return CustomInput(
      type: type,
      keyboardType: CustomTextInputType.phone,
      labelText: isAddAccount?AppLocalizations.of(context).folio : AppLocalizations.of(context).phoneNumberOrNumberClient,
      initValue: authBloc.state.phoneNumber.getValueOrElse(orElse: () => ''),
      onChanged: (text) {
        final AuthBloc authBloc = context.read<AuthBloc>();
        authBloc.add(AuthEvent.changePhoneNumber(phoneNumber: text));
      },
      validator:
          (_) => authBloc.state.phoneNumber.mapValidator(
            none: () => AppLocalizations.of(context).fillThisField,
            invalid: (l) => AppLocalizations.of(context).invalidPhoneNumber,
          ),
    );
  }

  Widget _forgotPassword(BuildContext context, {bool isAddAccount = false}) {
    return CustomButton(
      expanded: false,
      type: CustomButtonType.text,
      text: AppLocalizations.of(context).forgotPassword,
      onPressed: () {
        AutoRouter.of(context).push(LoginRoute(isAddAccount: isAddAccount));
      },
    );
  }

  BlocConsumer<AuthBloc, AuthState> _buttonLogin(bool isAddAccount) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen:
          (previous, current) =>
              previous.sendPinResponse != current.sendPinResponse,
      listener: (context, state) {
        state.sendPinResponse.customListenerResponse(
          error: (l) {
            showCustomSnackBar(
              context: context,
              type: CustomSnackBarType.error,
              message: l.message,
            );
          },
          response: (response) async {
            AutoRouter.of(context).push(
              LoginPinRoute(
                phoneNumber: response.phone,
                isAddAccount: isAddAccount,
                clientId: response.id,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        final loading = state.loading;
        final bool phoneNumber = state.phoneNumber.isValid();
        final enable = phoneNumber && !loading;
        return CustomButton(
          enable: enable,
          text: AppLocalizations.of(context).login,
          onPressed: () async {
            final AuthBloc authBloc = context.read<AuthBloc>();
            authBloc.add(AuthEvent.sendPin());
          },
        );
      },
    );
  }

  BlocConsumer<AuthBloc, AuthState> _buttonLoginPassword({
    required bool isAddAccount,
  }) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen:
          (previous, current) =>
              previous.loginWithPasswordResponse !=
              current.loginWithPasswordResponse,
      listener: (context, state) {
        state.loginWithPasswordResponse.customListenerResponse(
          error: (l) {
            showCustomSnackBar(
              context: context,
              type: CustomSnackBarType.error,
              message: l.message,
            );
          },
          response: (response) async {
            if (isAddAccount) {
              eventBus.fire(true);
              AutoRouter.of(context).replaceAll([DashboardRoute()]);
              return;
            }
            AutoRouter.of(context).replaceAll([DashboardRoute()]);
          },
        );
      },
      builder: (context, state) {
        final loading = state.loading;
        final bool phoneNumber = state.phoneNumber.isValid();
        final bool password = state.password.isValid();
        final enable = phoneNumber && password && !loading;
        return CustomButton(
          enable: enable,
          text: AppLocalizations.of(context).login,
          type: CustomButtonType.primary,
          onPressed: () async {
            final AuthBloc authBloc = context.read<AuthBloc>();
            authBloc.add(AuthEvent.loginWithPassword());
          },
        );
      },
    );
  }
}
