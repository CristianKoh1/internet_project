import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:moloch_app/application/home/home_bloc.dart';
import 'package:moloch_app/domain/core/event/event_bus.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/utils/logout.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    eventBus.on().listen(
      (_) => Future.delayed(Duration(seconds: 1), () => _init()),
    );
    super.initState();
  }

  void _init() {
    if (!mounted) return;
    context.read<HomeBloc>().add(HomeEvent.init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'Menú',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ..._accounts(state, context),
                ListTile(
                  leading: Icon(Icons.add_circle_outline_outlined),
                  title: Text(AppLocalizations.of(context).addAccount),
                  onTap: () {
                    AutoRouter.of(context).push(LoginRoute(isAddAccount: true));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text(AppLocalizations.of(context).changePassword),
                  onTap: () {
                    AutoRouter.of(
                      context,
                    ).push(ChangePasswordRoute(withPin: true));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(AppLocalizations.of(context).logout),
                  onTap: () {
                    LogoutUtils.showLogoutDialog(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state.invoicesResponse.customGetResponse(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (t) => Center(child: Text('Error al cargar')),
            response: (invoices) {
              if (invoices.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context).noInvoices),
                );
              }
              return ListView.builder(
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  final invoice = invoices[index];
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('N° Factura: ${invoice.id}'),
                        Text('${invoice.emitido} / ${invoice.vencimiento}'),
                        Text('MX\$${invoice.total}'),
                      ],
                    ),
                    leading: Icon(Icons.abc),
                    trailing: Text(invoice.estado),
                    onTap: () {},
                  );
                },
              );
            },
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
          "$subtitle${e.cliente} ${alias == null ? "" : (" - ${alias}")}",
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
