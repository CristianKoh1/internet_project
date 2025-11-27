part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.init() = HomeInit;
  const factory HomeEvent.changeAccount({required String idCliente}) = HomeChangeAccount;
  const factory HomeEvent.getInvoices() = HomeGetInvoices;
  const factory HomeEvent.getCurrentInvoice() = HomeGetCurrentInvoice;
  const factory HomeEvent.getInvoiceDetail({idfactura}) = HomeGetInvoiceDetail;
  const factory HomeEvent.getPayUrl({idfactura}) = HomeGetPayUrl;
}
