import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/presentation/pages/profile/widgets/change_password_confirm_pin_widget.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive_layout.dart';

@RoutePage()
class ChangePasswordConfirmPinPage extends StatelessWidget {
  final String password;
  const ChangePasswordConfirmPinPage({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(create: (_) => getIt<ProfileBloc>()),
      ],
      child: ResponsiveLayout(mobile: ChangePasswordConfirmPinWidget(password: password)),
    );
  }
}
