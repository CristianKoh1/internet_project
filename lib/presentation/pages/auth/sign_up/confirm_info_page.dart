import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/presentation/pages/auth/sign_up/widgets/confirm_info_widget.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive_layout.dart';

@RoutePage()
class ConfirmInfoPage extends StatelessWidget {
  final bool isSignUp;
  const ConfirmInfoPage({super.key, this.isSignUp = false});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (_) => getIt<ProfileBloc>()..add(
            const ProfileEvent.getBasicInfo(),
          ),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
        ),
      ],
      child: ResponsiveLayout(
        mobile: ConfirmInfoWidget(isSignUp: isSignUp),
      ),
    );
  }
}
