import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/auth/auth_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/presentation/pages/auth/login/widgets/login_pin_widget.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive_layout.dart';

@RoutePage()
class LoginPinPage extends StatelessWidget {
  final String clientId;
  final bool isAddAccount;
  final String phoneNumber;
  final bool isSignUp;
  const LoginPinPage({
    super.key,
    required this.phoneNumber,
    required this.clientId,
    this.isAddAccount = false, 
    this.isSignUp = false,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create:
              (_) =>
                  getIt<AuthBloc>()
                    ..add(AuthEvent.changePhoneNumber(phoneNumber: phoneNumber))
                    ..add(AuthEvent.changeClientId(id: clientId)),
        ),
      ],
      child: ResponsiveLayout(
        mobile: LoginPinWidget(
          isAddAccount: isAddAccount,
          phoneNumber: phoneNumber,
          isSignUp : isSignUp
        ),
      ),
    );
  }
}
