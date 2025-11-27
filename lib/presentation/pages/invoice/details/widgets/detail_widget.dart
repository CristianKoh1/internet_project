import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/home/home_bloc.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/utils/responsive/dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_snack_bar.dart';
import 'package:moloch_app/router/app_router.gr.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text(
          'Factura',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: _card(),
          ),
        ),
      ),
    );
  }

  Widget _card() {
    return BlocConsumer<HomeBloc, HomeState>(
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
        return state.getInvoiceDetailResponse.customGetResponse(
          loading:
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
          error:
              (f) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Text(
                        'Error al cargar los detalles de la factura.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
          response: (response) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado
                Text(
                  response.emisor[1].value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Detalle de tu factura',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 16),

                // Sección fecha y número
                _rowText('Emitido:', response.factura.emitido),
                _rowText('Vencimiento:', response.factura.vencimiento),
                const SizedBox(height: 4),
                _rowText('Factura N°', response.factura.id),

                const Divider(height: 24),

                response.items.isEmpty
                    ? Column(
                      children: [
                        const Text('No hay items en esta factura.'),
                        const Divider(height: 24),
                      ],
                    )
                    : Column(
                      children:
                          response.items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  // Servicio
                                  Text(
                                    item.descripcion,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const Divider(height: 24),
                                ],
                              ),
                            );
                          }).toList(),
                    ),

                // Resumen de cobro
                const Text(
                  'Resumen de cobro',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                _rowText(
                  'Total',
                  'MX\$${response.factura.total}',
                  isBold: true,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(
                        HomeEvent.getPayUrl(idfactura: response.factura.id),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE9F0FA),
                      foregroundColor: Colors.black87,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Pagar factura',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Widget auxiliar para filas de texto
  Widget _rowText(String left, String right, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
        Text(
          right,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
