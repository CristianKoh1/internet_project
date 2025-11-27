import 'package:flutter/material.dart';
import 'package:moloch_app/presentation/pages/auth/login/widgets/widgets.dart';
import 'package:moloch_app/presentation/widget/custom/custom_logo.dart';
import 'package:moloch_app/theme/extension.dart';

class LoginPasswordWidget extends StatelessWidget {
  final bool isAddAccount;
  const LoginPasswordWidget({super.key,required this.isAddAccount});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).extension<CustomColors>()?.primary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomLogo(black: false)),
            SliverToBoxAdapter(child: Icon(Icons.account_circle,size: 130,color: Theme.of(context).extension<CustomColors>()?.neutral100)),
            LoginWidgets().loginWithPasswordbody(context: context,isAddAccount: isAddAccount),
            LoginWidgets().loginWithPasswordButton(context: context,isAddAccount: isAddAccount,black: false),
          ],
        ),
      ),
    );
  }
}
