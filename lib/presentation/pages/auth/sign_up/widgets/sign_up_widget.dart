import 'package:flutter/material.dart';
import 'package:moloch_app/presentation/pages/auth/sign_up/widgets/widgets.dart';
import 'package:moloch_app/presentation/widget/custom/custom_logo.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomLogo(black: true)),
            SignUpWidgets().body(context: context),
            SignUpWidgets().signUpbuttons(context: context),
          ],
        ),
      ),
    );
  }
}
