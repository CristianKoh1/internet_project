import 'package:auto_route/auto_route.dart';
import 'package:fpdart/fpdart.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';
import 'package:moloch_app/domain/core/extension/option_object_value_extension.dart';
import 'package:moloch_app/domain/response/basic_info_model.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/utils/responsive/dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_button.dart';
import 'package:moloch_app/presentation/widget/custom/custom_input.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/presentation/widget/custom/custom_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:moloch_app/theme/extension.dart';

class SignUpWidgets {
  Widget buttons({required BuildContext context}) {
    return CustomPadding(child: _buttonLogin());
  }

  Widget signUpbuttons({required BuildContext context}) {
    return CustomPadding(
      sliver: true,
      child: SliverFillRemaining(
        hasScrollBody: false,
        child: Column(children: [Expanded(child: SizedBox()), _buttonLogin(),SizedBox(height: 20)]),
      ),
    );
  }

  Widget buttonsConfirmInfo({required BuildContext context,bool isSignUp = false}) {

    return CustomPadding(child: _buttonConfirmInfo(isSignUp: isSignUp));
  }

  CustomPadding body({required BuildContext context}) {
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
            _header(
              context,
              header: AppLocalizations.of(context).initWithPhone,
              message: AppLocalizations.of(context).send_message,
            ),
            //_name(context),
            _phoneNumber(context),
            //_email(context),
          ],
        ),
      ),
    );
  }

  Widget _header(
    BuildContext context, {
    required String header,
    required String message,
  }) {
    return Column(
      children: [
        _text(text: header, context: context),
        SizedBox(height: 15),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).extension<CustomColors>()?.neutral0,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Text _text({required String text, required BuildContext context}) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).extension<CustomColors>()?.neutral0,
      ),
      /* : Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral0,
              ) */
    );
  }

  CustomPadding confirmInfoBody({required BuildContext context}) {
    return CustomPadding(
      sliver: true,
      child: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment:
              kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            _header(
              context,
              header: AppLocalizations.of(context).validInfo,
              message: AppLocalizations.of(context).validInfoMessage,
            ),
            _information(),
          ],
        ),
      ),
    );
  }

  Widget _information() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.basicInfoResponse.customGetResponse(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (f) => Center(child: Text('Error al cargar')),
          response: (response) {
            final alias = response.alias;
            return Column(
              children: [
                SizedBox(height: 10),
                _info(
                  context,
                  property: '${AppLocalizations.of(context).name}:',
                  value: response.name,
                ),
                SizedBox(height: 10),
                _getAlias(context, alias),
                _info(
                  context,
                  property: '${AppLocalizations.of(context).phoneNumber}:',
                  value: response.phone,
                ),
                SizedBox(height: 10),
                _info(
                  context,
                  property: '${AppLocalizations.of(context).email}:',
                  value: response.email,
                ),
                SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }

  Widget _getAlias(BuildContext context, String? alias) {
    if (alias==null || alias.isEmpty) return SizedBox();
    
    return Column(
      children: [
        _info(
          context,
          property: '${AppLocalizations.of(context).alias}:',
          value: alias,
        ),
        SizedBox(height: 10),
      ],
    );
  }

  CustomPadding noClientBody({required BuildContext context}) {
    return CustomPadding(
      sliver: true,
      child: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment:
              kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            _header(
              context,
              header: AppLocalizations.of(context).noRegistered,
              message: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(
    BuildContext context, {
    required String property,
    required String value,
  }) {
    return Row(
      children: [
        Text(
          property,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).extension<CustomColors>()?.neutral0,
          ),
        ),
        SizedBox(width: 15),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).extension<CustomColors>()?.neutral0,
          ),
        ),
      ],
    );
  }

  Widget _name(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    return CustomInput(
      keyboardType: CustomTextInputType.text,
      labelText: AppLocalizations.of(context).name,
      initValue: authBloc.state.name.getValueOrElse(orElse: () => ''),
      onChanged: (text) {
        final AuthBloc authBloc = context.read<AuthBloc>();
        authBloc.add(AuthEvent.changeName(name: text));
      },
      validator:
          (_) => authBloc.state.name.mapValidator(
            none: () => AppLocalizations.of(context).fillThisField,
            invalid: (l) => AppLocalizations.of(context).fillThisField,
          ),
    );
  }

  Widget _email(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    return CustomInput(
      keyboardType: CustomTextInputType.email,
      labelText: AppLocalizations.of(context).email,
      initValue: authBloc.state.email.getValueOrElse(orElse: () => ''),
      onChanged: (text) {
        final AuthBloc authBloc = context.read<AuthBloc>();
        authBloc.add(AuthEvent.changeEmail(email: text));
      },
      validator:
          (_) => authBloc.state.email.mapValidator(
            none: () => AppLocalizations.of(context).fillThisField,
            invalid: (l) => AppLocalizations.of(context).invalidEmail,
          ),
    );
  }

  Widget _message(BuildContext context) {
    return Text(
      AppLocalizations.of(context).createAccount,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).extension<CustomColors>()?.neutral50,
      ),
    );
  }

  Widget _phoneNumber(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    return CustomInput(
      keyboardType: CustomTextInputType.phone,
      labelText: AppLocalizations.of(context).phoneNumberOrNumberClient,
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

  BlocConsumer<AuthBloc, AuthState> _buttonLogin() {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen:
          (previous, current) =>
              previous.sendPinResponse != current.sendPinResponse,
      listener: (context, state) {
        state.sendPinResponse.customListenerResponse(
          error: (l) {
            if (l.code == 404) {
              AutoRouter.of(context).push(NoClientRoute());
              return;
            }
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
                clientId: response.id,
                isSignUp: true,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        final loading = state.loading;
        final bool phoneNumber = state.phoneNumber.isValid();
        //final bool email = state.email.isValid();
        //final bool name = state.name.isValid();
        final enable = phoneNumber && !loading;
        return CustomButton(
          enable: enable,
          text: AppLocalizations.of(context).ccontinue,
          onPressed: () async {
            final AuthBloc authBloc = context.read<AuthBloc>();
            authBloc.add(AuthEvent.sendPin());
          },
        );
      },
    );
  }

  BlocConsumer<AuthBloc, AuthState> _buttonConfirmInfo({bool isSignUp = false}) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen:
          (previous, current) =>
              previous.sendPinResponse != current.sendPinResponse,
      listener: (context, state) {},
      builder: (context, state) {
        final loading = state.loading;
        final bool phoneNumber = state.phoneNumber.isValid();
        //final bool email = state.email.isValid();
        //final bool name = state.name.isValid();
        final bool termsAccepted = state.termsAccepted.getOrElse(() => false);
        final enable = termsAccepted && !loading;
        return CustomButton(
          enable: enable,
          text: AppLocalizations.of(context).ccontinue,
          onPressed: () async {
            if (isSignUp) {
              AutoRouter.of(context).replaceAll([DashboardRoute()]);
              return;
            }
            AutoRouter.of(context).push(ChangePasswordRoute());
          },
        );
      },
    );
  }
}
