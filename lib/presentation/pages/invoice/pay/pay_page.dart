import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moloch_app/domain/core/event/event_bus.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/utils/responsive/dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_pay_web_view_widget.dart';

@RoutePage()
class PayPage extends StatelessWidget {
  final String webViewUrl;

  const PayPage({super.key, required this.webViewUrl});

  @override
  Widget build(BuildContext context) {

    return CustomPayWebViewWidget(
      hasDialog: true,
      webViewUrl: webViewUrl,
      success: () async {
        AutoRouter.of(context).pop(true);
        /* RouterUtils.CustomHomePopUntil(
          context,
          nextRoute: SaveKycRoute(),
        ); */
      },
      error: (error) {
        /* context.read<LoanBloc>().add(
              LoanEvent.changeKycStatus(kycStatus: false),
            );
        context.read<KycBloc>().add(KycEvent.logVerificationError());
        showCustomSnackBar(
          context: context,
          type: CustomSnackBarType.error,
          message: error,
        ); */
      },
    );
  }
}
