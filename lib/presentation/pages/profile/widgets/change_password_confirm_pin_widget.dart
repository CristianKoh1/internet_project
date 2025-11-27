import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/utils/responsive/dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_pin_code.dart';
import 'package:moloch_app/presentation/widget/custom/custom_snack_bar.dart';
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ChangePasswordConfirmPinWidget extends StatefulWidget {
  final String password;
  const ChangePasswordConfirmPinWidget({super.key, required this.password});

  @override
  State<ChangePasswordConfirmPinWidget> createState() =>
      _ChangePasswordConfirmPinWidgetState();
}

class _ChangePasswordConfirmPinWidgetState
    extends State<ChangePasswordConfirmPinWidget> {
  bool isLoading = false;
  late ActiveGuardObserver guardObserver;
  late VoidCallback guardListener;
  StreamSubscription? _subscription;

  @override
  void initState() {
    guardObserver = context.router.activeGuardObserver;

    guardListener = () {
      setState(() {
        isLoading = guardObserver.guardInProgress;
      });
    };
    guardObserver.addListener(guardListener);
    sms();
    super.initState();
  }

  sms() async {
    await SmsAutoFill().listenForCode(smsCodeRegexPattern: r'\d{6,}');
    _subscription = SmsAutoFill().code.listen((code) {
      if (!mounted) return;
      context.read<ProfileBloc>().add(
        ProfileEvent.changePasswordWithPin(
          pin: code,
          password: widget.password,
        ),
      );
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _subscription?.cancel();
    guardObserver.removeListener(guardListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen:
          (previous, current) =>
              previous.setPasswordResponse != current.setPasswordResponse,
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
            showCustomSnackBar(
              context: context,
              type: CustomSnackBarType.success,
              message: AppLocalizations.of(context).passwordChangedSuccessfully,
            );
            Future.delayed(
              const Duration(seconds: 2),
              () => AutoRouter.of(context).replaceAll([DashboardRoute()]),
            );
          },
        );
      },
      builder: (context, state) {
        return CustomPinCode(
          customPinCodeType: CustomPinCodeType.logInFirstTime,
          enable: true,
          onConfirm:
              (pin) => context.read<ProfileBloc>().add(
                ProfileEvent.changePasswordWithPin(
                  pin: pin,
                  password: widget.password,
                ),
              ),
          loading: state.loading,
          loadingText: '',
        );
      },
    );
  }
}
