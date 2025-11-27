import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/home/home_bloc.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/presentation/pages/dashboard/widgets/dashboard_widget.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create:
              (context) =>
                  getIt<HomeBloc>()
                    ..add(HomeEvent.init()),
        ),
        BlocProvider(
          create:
              (context) =>
                  getIt<ProfileBloc>(),
        ),
      ],
      child: DashbordWidget(),
    );
  }
}
