import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/pages/auth/login/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:moloch_app/presentation/widget/custom/custom_app_bar.dart';
import 'package:moloch_app/presentation/widget/custom/custom_logo.dart';
import 'package:moloch_app/theme/extension.dart';

class LoginWidget extends StatelessWidget {
  final bool isAddAccount;
  const LoginWidget({super.key, required this.isAddAccount});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomLogo()),
            LoginWidgets().loginBody(context: context,isAddAccount: isAddAccount),
            LoginWidgets().loginButtons(context: context,isAddAccount:isAddAccount),
          ],
        ),
      ),
    );
  }
}
