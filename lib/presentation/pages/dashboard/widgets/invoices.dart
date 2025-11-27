import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/home/home_bloc.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:badges/badges.dart' as badges;
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:moloch_app/theme/extension.dart';

class Invoices extends StatelessWidget {
  const Invoices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context).invoices,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(child: invoiceList()),
          ],
        ),
      ),
    );
  }

  Widget invoiceList() {
    return BlocBuilder<HomeBloc, HomeState>(
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
              padding: EdgeInsets.all(16),
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final inv = invoices[index];
                Color badgeColor;
                String badgeText;

                switch (inv.estado.toLowerCase()) {
                  case 'pagado':
                    badgeColor = Colors.green;
                    badgeText = 'Pagado';
                    break;
                  case 'no pagado':
                    badgeColor = Colors.red;
                    badgeText = 'No pagado';
                    break;
                  default:
                    badgeColor = Colors.grey;
                    badgeText = 'Desconocido';
                }

                return Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                    AutoRouter.of(context).push(DetailRoute(idFactura: inv.id));
                  },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          // Datos de la factura
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'N° ${inv.id}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${inv.emitido}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                          // Badge de estado
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: badgeColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    badgeText,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context)
                                              .extension<CustomColors>()
                                              ?.neutral100,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                                    
                              Text(
                                'MX\$${inv.total}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
