import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/presentation/pages/profile/widgets/change_password_widget.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive_layout.dart';

@RoutePage()
class ChangePasswordPage extends StatelessWidget {
  final bool withPin;
  const ChangePasswordPage({super.key, this.withPin = false});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(create: (_) => getIt<ProfileBloc>()),
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
      ],
      child: ResponsiveLayout(mobile: ChangePasswordWidget(withPin: withPin)),
    );
  }
}
