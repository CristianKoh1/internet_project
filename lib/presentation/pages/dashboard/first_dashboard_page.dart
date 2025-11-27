import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/home/home_bloc.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/presentation/pages/dashboard/widgets/dashboard_widget.dart';

@RoutePage()
class FirstDashboardPage extends StatelessWidget {
  const FirstDashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create:
              (context) =>
                  getIt<HomeBloc>()
                    ..add(HomeEvent.init())
                    ..add(HomeEvent.getInvoices())
                    ..add(HomeEvent.getCurrentInvoice()),
        ),
        BlocProvider(
          create:
              (context) => getIt<ProfileBloc>()..add(ProfileEvent.getPlan()),
        ),
      ],
      child: DashbordWidget(),
    );
  }
}
