import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/presentation/pages/auth/sign_up/widgets/sign_up_widget.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive_layout.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
        ),
      ],
      child: ResponsiveLayout(
        mobile: const SignUpWidget(),
      ),
    );
  }
}
