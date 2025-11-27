import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/domain/core/event/event_bus.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';
import 'package:moloch_app/presentation/utils/responsive/dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_pin_code.dart';
import 'package:moloch_app/presentation/widget/custom/custom_snack_bar.dart';
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPinWidget extends StatefulWidget {
  final bool isAddAccount;
  final String phoneNumber;
  final bool isSignUp;
  const LoginPinWidget({
    super.key,
    this.isAddAccount = false,
    required this.phoneNumber, 
    required this.isSignUp,
  });

  @override
  State<LoginPinWidget> createState() => _LoginPinWidgetState();
}

class _LoginPinWidgetState extends State<LoginPinWidget> {
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
      context.read<AuthBloc>().add(AuthEvent.loginPin(pin: code));
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _subscription?.cancel();
    guardObserver.removeListener(guardListener);
    super.dispose();
  }

  /*  void _startListeningSms() {
      final otp = SmsVerification.getCode(message, intRegex);
      if (!mounted) return;
      context.read<AuthBloc>().add(AuthEvent.loginPin(pin: otp));
  } */

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen:
          (previous, current) =>
              previous.loginPinResponseModel != current.loginPinResponseModel,
      listener: (context, state) {
        state.loginPinResponseModel.customListenerResponse(
          error: (failure) {
            showCustomSnackBar(
              context: context,
              type: CustomSnackBarType.error,
              message: failure.message,
            );
          },
          response: (_) {
            if (widget.isAddAccount) {
              eventBus.fire(true);
              AutoRouter.of(context).replace(ConfirmInfoRoute(isSignUp: true));
              return;
            }
            if (widget.isSignUp) {
              AutoRouter.of(context).replaceAll([ConfirmInfoRoute()]);
              return;
            }
            AutoRouter.of(context).replaceAll([ChangePasswordRoute()]); // Navigate to Change Password
          },
        );
      },
      builder: (context, state) {
        return CustomPinCode(
          phoneNumber: widget.phoneNumber,
          customPinCodeType: CustomPinCodeType.logInFirstTime,
          enable: true,
          onConfirm:
              (pin) =>
                  context.read<AuthBloc>().add(AuthEvent.loginPin(pin: pin)),
          loading: state.loading || isLoading,
          loadingText: '',
        );
      },
    );
  }
}
