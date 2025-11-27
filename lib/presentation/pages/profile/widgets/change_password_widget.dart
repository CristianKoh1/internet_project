import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';
import 'package:moloch_app/domain/core/extension/option_object_value_extension.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:moloch_app/presentation/utils/responsive/dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_button.dart';
import 'package:moloch_app/presentation/widget/custom/custom_input.dart';
import 'package:moloch_app/presentation/widget/custom/custom_logo.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/presentation/widget/custom/custom_snack_bar.dart';
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:moloch_app/theme/extension.dart';

class ChangePasswordWidget extends StatelessWidget {
  final bool withPin;
  const ChangePasswordWidget({super.key, required this.withPin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomLogo(black: true)),
            _header(
              context,
              header: AppLocalizations.of(context).changePasswordTitle,
              message: AppLocalizations.of(context).changePasswordMessage,
            ),
            _inputPassword(context),
            _inputConfirmPassword(context),
            _tips(context),
            _button(context),
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
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _text(
            text: header,
            context: context,
          ),
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
      ),
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

  Widget _inputPassword(BuildContext context) {
    return CustomPadding(
      sliver: true,
      child: SliverToBoxAdapter(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return CustomInput(
              keyboardType: CustomTextInputType.password,
              labelText: AppLocalizations.of(context).newpPassword,
              obscureText: true,
              onChanged: (value) {
                context.read<ProfileBloc>().add(
                  ProfileEvent.changePassword(password: value),
                );
              },
              validator:
                  (_) => state.password.mapValidator(
                    none: () => AppLocalizations.of(context).fillThisField,
                    invalid:
                        (l) => AppLocalizations.of(context).invalidPhoneNumber,
                  ),
            );
          },
        ),
      ),
    );
  }

  Widget _inputConfirmPassword(BuildContext context) {
    return CustomPadding(
      sliver: true,
      child: SliverToBoxAdapter(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return CustomInput(
              keyboardType: CustomTextInputType.password,
              obscureText: true,
              hintText: AppLocalizations.of(context).confirmPassword,
              labelText: AppLocalizations.of(context).confirmPassword,
              onChanged: (value) {
                context.read<ProfileBloc>().add(
                  ProfileEvent.changeConfirmPassword(password: value),
                );
              },
              validator: (text) {
                final confirmPassword = state.confirmPassword.getValueOrElse(
                  orElse: () => '',
                );
                final password = state.password.getValueOrElse(
                  orElse: () => '',
                );

                if (confirmPassword != password)
                  return AppLocalizations.of(context).passwordsNotMatch;
                return null;
              },
            );
          },
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomPadding(
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listenWhen:
                  (previous, current) =>
                      previous.setPasswordResponse !=
                          current.setPasswordResponse ||
                      previous.sendPinResponse != current.sendPinResponse,
              listener: (context, state) {
                state.setPasswordResponse.customListenerResponse(
                  error: (failure) {
                    showCustomSnackBar(
                      context: context,
                      type: CustomSnackBarType.error,
                      message: failure.message,
                    );
                  },
                  response: (_) {
                    AutoRouter.of(context).replaceAll([DashboardRoute()]);
                  },
                );
              },
              builder: (context, state) {
                final confirmPassword = state.confirmPassword.getValueOrElse(
                  orElse: () => '',
                );
                final password = state.password.getValueOrElse(
                  orElse: () => '',
                );

                var matchPassword = confirmPassword == password;
                return CustomButton(
                  enable:
                      state.password.isValid() &&
                      matchPassword &&
                      !state.loading,
                  text: AppLocalizations.of(context).save,
                  onPressed: () {
                    if (withPin) {
                      context.read<ProfileBloc>().add(
                        const ProfileEvent.sendPin(),
                      );
                       AutoRouter.of(context).push(
                        ChangePasswordConfirmPinRoute(password: password),
                      );
                      return;
                    }
                    context.read<ProfileBloc>().add(
                      const ProfileEvent.setPassword(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _tips(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomPadding(
        child: Text(
          AppLocalizations.of(context).passwordSecurityTips,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
