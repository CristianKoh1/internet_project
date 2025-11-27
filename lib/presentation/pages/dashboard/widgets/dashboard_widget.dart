import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:moloch_app/application/home/home_bloc.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/domain/auth/i_auth_repository.dart';
import 'package:moloch_app/domain/core/event/event_bus.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/pages/dashboard/widgets/help.dart';
import 'package:moloch_app/presentation/pages/dashboard/widgets/home.dart';
import 'package:moloch_app/presentation/pages/dashboard/widgets/invoices.dart';
import 'package:moloch_app/presentation/utils/firebase_manager.dart';
import 'package:moloch_app/presentation/utils/logout.dart';
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:moloch_app/theme/extension.dart';

@RoutePage()
class DashbordWidget extends StatefulWidget {
  const DashbordWidget({super.key});

  @override
  State<DashbordWidget> createState() => _DashbordWidgetState();
}

class _DashbordWidgetState extends State<DashbordWidget> {
  final firebaseManager = FirebaseManager();

  @override
  void initState() {
    firebaseManager.onListerners(context);
    _saveToken();
    eventBus.on().listen(
      (_) => Future.delayed(const Duration(seconds: 1), _init),
    );
    super.initState();
  }

  void _init() {
    if (!mounted) return;
    context.read<HomeBloc>().add(const HomeEvent.init());
  }

  int _selectedIndex = 0;

  // El contenido para cada pestaña
  static const List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    Invoices(),
    Help(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _saveToken() async {
    final IAuthRepository authRepository = getIt<IAuthRepository>();
    await FirebaseManager.requestPermissionNotification();
    final token = await FirebaseManager.getToken();
    await FirebaseManager.subscribeToAllTopic();
    if (token == null) return;
    print("Firebase Token: $token");
    authRepository.saveFirebaseToken(token: token);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) => 
        previous.activeAccount != current.activeAccount,
      listener: (context, state) {
        if (state.activeAccount.isSome()) {
          context.read<ProfileBloc>().add(
            ProfileEvent.getPlan()
          );
          context.read<ProfileBloc>().add(
            ProfileEvent.getTraffic()
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: _drawer(),
        body: Stack(
          children: [_widgetOptions.elementAt(_selectedIndex), _appBar()],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => _onItemTapped(0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color:
                            _selectedIndex == 0 ? Colors.blue : Colors.black54,
                      ),
                      Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              _selectedIndex == 0
                                  ? Colors.blue
                                  : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => _onItemTapped(1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        color:
                            _selectedIndex == 1
                                ? Colors.blueAccent
                                : Colors.black54,
                      ),
                      Text(
                        'Facturas',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              _selectedIndex == 1
                                  ? Colors.blue
                                  : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => _onItemTapped(2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.help_outline,
                        color:
                            _selectedIndex == 2
                                ? Colors.blueAccent
                                : Colors.black54,
                      ),
                      Text(
                        'Ayuda',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              _selectedIndex == 2
                                  ? Colors.blue
                                  : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned _appBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder:
                    (context) => IconButton(
                      icon: Icon(
                        Icons.menu,
                        color:
                            Theme.of(
                              context,
                            ).extension<CustomColors>()?.neutral100,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color:
                      Theme.of(context).extension<CustomColors>()?.neutral100,
                ),
                onPressed: () {
                  // TODO: Acción notificaciones
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer _drawer() {
    return Drawer(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF0C8AFC)),
                child: Text(
                  'Menú',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ..._accounts(state, context),
              ListTile(
                leading: const Icon(Icons.add_circle_outline_outlined),
                title: Text(AppLocalizations.of(context).addAccount),
                onTap: () {
                  AutoRouter.of(context).push(LoginRoute(isAddAccount: true));
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: Text(AppLocalizations.of(context).changePassword),
                onTap: () {
                  AutoRouter.of(
                    context,
                  ).push(ChangePasswordRoute(withPin: true));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(AppLocalizations.of(context).logout),
                onTap: () {
                  LogoutUtils.showLogoutDialog(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _accounts(HomeState state, BuildContext context) {
    final accounts = state.accounts.getOrElse(() => []);
    final subtitle = '${AppLocalizations.of(context).client}: ';
    final activeAccount = state.activeAccount.fold(
      () => null,
      (account) => account,
    );
    return accounts.map((e) {
      final alias = e.alias;
      return ListTile(
        title: Text(e.nombre),
        subtitle: Text(
          '$subtitle${e.cliente} ${alias == null ? '' : (' - $alias')}',
        ),
        enabled: activeAccount?.cliente != e.cliente,
        onTap: () {
          context.read<HomeBloc>().add(
            HomeEvent.changeAccount(idCliente: e.cliente),
          );
          AutoRouter.of(context).pop();
        },
      );
    }).toList();
  }
}
