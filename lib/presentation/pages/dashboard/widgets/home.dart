import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moloch_app/application/home/home_bloc.dart';
import 'package:moloch_app/application/profile/profile_bloc.dart';
import 'package:moloch_app/domain/core/event/event_bus.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/pages/dashboard/widgets/custom_pie.dart';
import 'package:moloch_app/presentation/utils/responsive/dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/presentation/widget/custom/custom_snack_bar.dart';
import 'package:moloch_app/router/app_router.gr.dart';
import 'package:moloch_app/theme/extension.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0400A9), Color(0xFF0C8AFC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(child: Stack(children: [_marcaAgua(), _body(context)])),
      ),
    );
  }

  Widget _marcaAgua() {
    return Positioned(
      left: -120,
      child: Column(
        children: [
          SizedBox(height: 40),
          SvgPicture.asset(
            'assets/icons/marca_agua.svg',
            height: 500,
            width: 500,
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.activeAccount.fold(() => SizedBox(), (r) {
              final name = r.nombre;
              return Text(
                'Hola, $name',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color:
                      Theme.of(context).extension<CustomColors>()?.neutral100,
                  fontWeight: FontWeight.bold,
                ),
              );
            });
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.currentInvoiceResponse.fold(
              () => SizedBox(),
              (invoice) => invoice.fold(
                (failure) => Text(
                  'Error al cargar la factura',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color:
                        Theme.of(context).extension<CustomColors>()?.neutral100,
                  ),
                ),
                (currentInvoice) {
                  if (currentInvoice == null) {
                    return SizedBox();
                  }
                  return Text(
                    'Folio Cliente: ${currentInvoice.idClient}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color:
                          Theme.of(
                            context,
                          ).extension<CustomColors>()?.neutral100,
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 5),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return state.getPlanResponse.customGetResponse(
              loading: () => SizedBox(),
              error: (l) => SizedBox(),
              response: (plans) {
                return Column(
                  children:
                      plans
                          .asMap()
                          .entries
                          .map(
                            (e) => Column(
                              children: [
                                Text(
                                  'Paquete ${plans.length >= 2 ? (e.key + 1) : ""}: ${e.value.plan}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    color:
                                        Theme.of(
                                          context,
                                        ).extension<CustomColors>()?.neutral100,
                                  ),
                                ),
                                SizedBox(height: 14),
                                _target(context, e.value.estado),
                              ],
                            ),
                          )
                          .toList(),
                );
              },
            );
          },
        ),
        const SizedBox(height: 12),
        _paymentInfo(context),

        // Indicador de consumo
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final panelHeight = 110.0;
              final circleOverlap = 100.0;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Gráfico
                  Positioned(
                    bottom: panelHeight - circleOverlap - 30,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return state.getTrafficResponse.customGetResponse(
                            loading: () => SizedBox(),
                            error: (l) => SizedBox(),
                            response: (traffic) {
                              return AnimatedInternetSpeedGauge(
                                porcentaje: .50,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  // Panel inferior blanco
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: panelHeight - 45,
                      child: bottonPannel(context),
                    ),
                  ),

                  // Círculo sobre el panel, sobresaliendo
                  Positioned(
                    bottom: panelHeight - circleOverlap,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: _circle(context, consumo: '15', mbs: '30'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _target(BuildContext context, String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      decoration: BoxDecoration(
        color:
            status == 'ACTIVO'
                ? Theme.of(context).extension<CustomColors>()?.lightBlue
                : Theme.of(context).extension<CustomColors>()?.red,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        'Servicio $status',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).extension<CustomColors>()?.neutral100,
        ),
      ),
    );
  }

  Widget bottonPannel(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).extension<CustomColors>()?.neutral100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
    );
  }

  Widget _circle(
    BuildContext context, {
    required String consumo,
    required String mbs,
  }) {
    return Container(
      width: 198,
      height: 198,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, // Color de la sombra
            blurRadius: 10, // Desenfoque de la sombra
            offset: Offset(0, 4), // Desplazamiento de la sombra
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Consumo',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'del mes',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral50,
                fontWeight: FontWeight.bold,
              ),
            ),

            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return state.getTrafficResponse.customGetResponse(
                  loading: () => SizedBox(),
                  error: (l) => SizedBox(),
                  response: (traffic) {
                    return Text(
                      traffic.descarga,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Color(0XFF7A1FA2),
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 35),
            /* Text(
              'mbps',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(
                text: 'De ',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).extension<CustomColors>()?.neutral50,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: mbs,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Color(0XFF0400A8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' mpbs',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color:
                          Theme.of(
                            context,
                          ).extension<CustomColors>()?.neutral50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ), */
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.currentInvoiceResponse.fold(
          () => SizedBox(),
          (invoice) => invoice.fold((failure) => SizedBox(), (currentInvoice) {
            if (currentInvoice == null) {
              return SizedBox();
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white),
              ),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return state.currentInvoiceResponse.fold(
                    () => SizedBox(),
                    (invoice) =>
                        invoice.fold((failure) => SizedBox(), (currentInvoice) {
                          if (currentInvoice == null) {
                            return SizedBox();
                          }
                          return _cardBody(context);
                        }),
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }

  Column _cardBody(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.currentInvoiceResponse.fold(
              () => SizedBox(),
              (invoice) => invoice.fold((failure) => SizedBox(), (
                currentInvoice,
              ) {
                if (currentInvoice == null) {
                  return SizedBox();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Factura N° ${currentInvoice.idBill}:',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color:
                            Theme.of(
                              context,
                            ).extension<CustomColors>()?.neutral100,
                      ),
                    ),
                    SizedBox(height: 35),
                    Text(
                      currentInvoice.statusBill,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color:
                            Theme.of(
                              context,
                            ).extension<CustomColors>()?.neutral100,
                      ),
                    ),
                  ],
                );
              }),
            );
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Fecha limite pronto pago:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color:
                        Theme.of(context).extension<CustomColors>()?.neutral100,
                  ),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return state.currentInvoiceResponse.fold(
                      () => SizedBox(),
                      (invoice) => invoice.fold((failure) => SizedBox(), (
                        currentInvoice,
                      ) {
                        if (currentInvoice == null) {
                          return SizedBox();
                        }
                        return Text(
                          currentInvoice.limitDate,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(
                                  context,
                                ).extension<CustomColors>()?.neutral100,
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return state.currentInvoiceResponse.fold(
                  () => SizedBox(),
                  (invoice) => invoice.fold(
                    (failure) => Text(
                      '---',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color:
                            Theme.of(
                              context,
                            ).extension<CustomColors>()?.neutral100,
                      ),
                    ),
                    (currentInvoice) {
                      if (currentInvoice == null) {
                        return SizedBox();
                      }
                      return Text(
                        '\$${currentInvoice.totalBefore}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color:
                              Theme.of(
                                context,
                              ).extension<CustomColors>()?.neutral100,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Después de la fecha:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral100,
              ),
            ),
            SizedBox(height: 35),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return state.currentInvoiceResponse.fold(
                  () => SizedBox(),
                  (invoice) => invoice.fold(
                    (failure) => Text(
                      '---',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color:
                            Theme.of(
                              context,
                            ).extension<CustomColors>()?.neutral100,
                      ),
                    ),
                    (currentInvoice) {
                      if (currentInvoice == null) {
                        return SizedBox();
                      }
                      return Text(
                        '\$${currentInvoice.totalAfter}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color:
                              Theme.of(
                                context,
                              ).extension<CustomColors>()?.neutral100,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _paymentInfo(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.currentInvoiceResponse.fold(
              () => SizedBox(),
              (invoice) => invoice.fold(
                (failure) => Text(
                  'Error al cargar la factura',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color:
                        Theme.of(context).extension<CustomColors>()?.neutral100,
                  ),
                ),
                (currentInvoice) {
                  if (currentInvoice == null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Estas al día con tus pagos',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color:
                              Theme.of(
                                context,
                              ).extension<CustomColors>()?.neutral100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return Text(
                    'Saldo a pagar',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color:
                          Theme.of(
                            context,
                          ).extension<CustomColors>()?.neutral100,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        _card(context),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.center,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return state.currentInvoiceResponse.fold(
                () => SizedBox(),
                (invoice) => invoice.fold(
                  (failure) => Text(
                    'Error al cargar la factura',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color:
                          Theme.of(
                            context,
                          ).extension<CustomColors>()?.neutral100,
                    ),
                  ),
                  (currentInvoice) {
                    if (currentInvoice == null) {
                      return SizedBox();
                    }
                    return Text(
                      'Fecha de suspension: ${currentInvoice.cutDate}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color:
                            Theme.of(
                              context,
                            ).extension<CustomColors>()?.neutral100,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        BlocConsumer<HomeBloc, HomeState>(
          listenWhen:
              (previous, current) =>
                  previous.getPayUrlResponse != current.getPayUrlResponse,
          listener: (context, state) {
            state.getPayUrlResponse.customListenerResponse(
              error: (failure) {
                showCustomSnackBar(
                  context: context,
                  type: CustomSnackBarType.error,
                  message: failure.message,
                );
              },
              response: (url) async {
                final bool? result = await AutoRouter.of(
                  context,
                ).push<bool?>(PayRoute(webViewUrl: url));

                if (!context.mounted) return;

                if (result == true) {
                  Future.delayed(Duration(seconds: 1), () {
                    showCustomDialog(
                      context,
                      imageUrl: 'assets/logo/logo.png',
                      title: AppLocalizations.of(context).successPayTitle,
                      message: AppLocalizations.of(context).successPayMessage,
                      primaryButtonText: AppLocalizations.of(context).ccontinue,
                      primaryButtonCallback: () {
                        AutoRouter.of(context).pop();
                      },
                    );
                  });
                }
              },
            );
          },
          builder: (context, state) {
            
            return state.currentInvoiceResponse.fold(
              () => Center(child: CircularProgressIndicator.adaptive()),
              (invoice) => invoice.fold(
                (failure) => Text(
                  'Error al cargar la factura',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color:
                        Theme.of(context).extension<CustomColors>()?.neutral100,
                  ),
                ),
                (currentInvoice) {
                  if (currentInvoice == null) {
                    return SizedBox();
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF01158E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 105,
                        vertical: 0,
                      ),
                    ),
                    onPressed: () {
                      context.read<HomeBloc>().add(
                        HomeEvent.getPayUrl(idfactura: currentInvoice.idBill),
                      );
                    },
                    child: _contentButton(context, state),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _contentButton(BuildContext context, HomeState state) {
    if (state.loading) {
      return Container(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(
          color: Theme.of(context).extension<CustomColors>()?.neutral100,
          strokeWidth: 2,
        ),
      );
    }
    return Text(
      'PAGAR',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).extension<CustomColors>()?.neutral100,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
