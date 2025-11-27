import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/home/home_bloc.dart';
import 'package:moloch_app/config/injectable.dart';
import 'package:moloch_app/presentation/pages/invoice/details/widgets/detail_widget.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive_layout.dart';

@RoutePage()
class DetailPage extends StatelessWidget {
  final String idFactura;
  const DetailPage({super.key, required this.idFactura});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => getIt<HomeBloc>()..add(HomeEvent.getInvoiceDetail(idfactura: idFactura)),
        ),
      ],
      child: ResponsiveLayout(mobile: const DetailWidget()),
    );
  }
}
