import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/core/account.dart';
import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/invoices/i_invoice_repository.dart';
import 'package:moloch_app/domain/local/i_local_repository.dart';
import 'package:moloch_app/domain/response/current_invoice_model.dart';
import 'package:moloch_app/domain/response/invoice_model.dart';
import 'package:moloch_app/domain/response/invoice_response_model.dart';
part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ILocalRepository localRepository;
  final IInvoiceRepository invoiceRepository;

  HomeBloc(this.localRepository, this.invoiceRepository)
    : super(const HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      switch (event) {
        case HomeInit():
          await _init(event, emit);
          break;
        case HomeChangeAccount():
          await _changeAccount(event, emit);
          break;
        case HomeGetInvoices():
          await _getInvoices(event, emit);
          break;
        case HomeGetCurrentInvoice():
          await _getCurrentInvoice(event, emit);
          break;
        case HomeGetPayUrl():
          await _getPayUrl(event, emit);
          break;
        case HomeGetInvoiceDetail():
          await _getInvoiceDetail(event, emit);
          break;
      }
    });
  }

  Future<void> _init(HomeInit event, Emitter<HomeState> emit) async {
    emit(state.copyWith(accounts: none(), activeAccount: none()));

    final activeAccount = await localRepository.getActiveAccount();
    final accounts = await localRepository.getAccounts();
    add(HomeEvent.getInvoices());
    add(HomeEvent.getCurrentInvoice());
    emit(
      state.copyWith(
        accounts: some(accounts),
        activeAccount: activeAccount == null ? none() : some(activeAccount),
      ),
    );
  }

  Future<void> _changeAccount(
    HomeChangeAccount event,
    Emitter<HomeState> emit,
  ) async {
    await localRepository.switchToAccount(event.idCliente);
    add(HomeEvent.init());
  }

  Future<void> _getInvoices(
    HomeGetInvoices event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(loading: true, invoicesResponse: none()));

    final invoicesResponse = await invoiceRepository.getInvoices();

    emit(
      state.copyWith(loading: false, invoicesResponse: some(invoicesResponse)),
    );
  }

  Future<void> _getCurrentInvoice(
    HomeGetCurrentInvoice event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(loading: true, currentInvoiceResponse: none()));

    final currentInvoiceResponse = await invoiceRepository.getCurrentInvoice();

    emit(
      state.copyWith(
        loading: false,
        currentInvoiceResponse: some(currentInvoiceResponse),
      ),
    );
  }

  Future<void> _getPayUrl(HomeGetPayUrl event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loading: true, getPayUrlResponse: none()));
    final getPayUrlResponse = await invoiceRepository.getPayUrl(
      idfactura: event.idfactura,
    );
    emit(
      state.copyWith(
        loading: false,
        getPayUrlResponse: some(getPayUrlResponse),
      ),
    );
  }

  Future<void> _getInvoiceDetail(
    HomeGetInvoiceDetail event,
    Emitter<HomeState> emit,
  ) async{
    emit(state.copyWith(loading: true, getInvoiceDetailResponse: none()));

    final getInvoiceDetailResponse = await invoiceRepository.getInvoiceDetail(idfactura: event.idfactura);

    emit(
      state.copyWith(
        loading: false,
        getInvoiceDetailResponse: some(getInvoiceDetailResponse),
      ),
    );
  }
}
