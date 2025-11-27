import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/presentation/pages/auth/login/widgets/login_with_password_widget.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive_layout.dart';

@RoutePage()
class LoginPasswordPage extends StatelessWidget {
  final bool isAddAccount;
  const LoginPasswordPage({super.key,this.isAddAccount = false});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>())],
      child: ResponsiveLayout(mobile: LoginPasswordWidget(isAddAccount: isAddAccount)),
    );
  }
}
