import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/widget/custom/custom_circular_progress_indicator.dart';
import 'package:moloch_app/presentation/widget/custom/custom_logo.dart';
import 'package:moloch_app/presentation/widget/custom/custom_pin_widget.dart';
import 'package:moloch_app/presentation/widget/web_friendly_scaffold.dart';
import 'package:moloch_app/theme/extension.dart';

enum CustomPinCodeType {
  register,
  recoverPin,
  confirmRequest,
  confirmApproval,
  logInFirstTime,
  logIn,
  deleteAcount,
}

class CustomPinCode extends StatefulWidget {
  final CustomPinCodeType customPinCodeType;
  final bool enable;
  final bool confirm;
  final Function()? onBiometric;
  final Function(String)? onConfirm;
  final bool logOut;
  final bool loading;
  final String loadingText;
  final String? phoneNumber;

  const CustomPinCode({
    Key? key,
    this.customPinCodeType = CustomPinCodeType.register,
    this.enable = true,
    this.confirm = false,
    this.onBiometric,
    this.onConfirm,
    this.logOut = false,
    this.loading = false,
    this.loadingText = '',
    this.phoneNumber,
  }) : super(key: key);

  @override
  State<CustomPinCode> createState() => _CustomPinCodeState();
}

class _CustomPinCodeState extends State<CustomPinCode> {
  final textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late String pin;
  late List<bool> isCircleFilled;

  @override
  void initState() {
    super.initState();
    pin = '';
    isCircleFilled = List.generate(6, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WebFriendlyScaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _background(context),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _login(),
                ),
                _logOut(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _background(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).extension<CustomColors>()?.neutral100,
      ),
    );
  }

  Center _loading() {
    return Center(
      child: Column(
        children: [
          CustomCircularProgressIndicator(),
          Text(
            widget.loadingText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color:
                      Theme.of(context).extension<CustomColors>()?.neutral30,
                ),
          )
        ],
      ),
    );
  }

  Widget _login() {
    final phoneNumber = widget.phoneNumber ?? '';
    final lastTwoDigits = phoneNumber.length >= 2
        ? phoneNumber.substring(phoneNumber.length - 2)
        : phoneNumber;

    return Padding(
      padding: const EdgeInsets.only(top: 90,bottom: 30),  
      child: Column(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: Theme.of(context).extension<CustomColors>()?.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.lock_open_outlined,
                color: Theme.of(context).extension<CustomColors>()?.neutral100,
                size: 90,
              ),
            ),
          ),
          SizedBox(height: 40),
          widget.loading
              ? _loading()
              : CustomPinWidget(
                  enable: true,
                  header: AppLocalizations.of(context).enterPin,
                  message: AppLocalizations.of(context).enterPinMessage + lastTwoDigits,
                  isFooter: true,
                  footer: AppLocalizations.of(context).forgotPin,
                  isBiometric: !kIsWeb,
                  onBiometric: () async => widget.onBiometric?.call(),
                  onConfirm: (newPin) => widget.onConfirm?.call(newPin),
                ),
        ],
      ),
    );
  }

  Widget _getLogo() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 32),
      child: CustomLogo(
        type: CustomLogoType.pinLogo,
      ),
    );
  }

  Text _loginText() {
    return Text(
      AppLocalizations.of(context).welcomeBack,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).extension<CustomColors>()?.neutral0,
          ),
    );
  }

  Widget _logOut(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      fillOverscroll: true,
      child: widget.logOut
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _logOutText(context),
              ],
            )
          : SizedBox(),
    );
  }

  Widget _logOutText(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(
          Colors.transparent,
        ),
      ),
      onPressed: () {},
      child: Text(
       AppLocalizations.of(context).logout,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).extension<CustomColors>()?.neutral0,
            ),
      ),
    );
  }
}
