import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_invoice_model.freezed.dart';
part 'current_invoice_model.g.dart';

@freezed
abstract class CurrentInvoiceModel with _$CurrentInvoiceModel {
  const factory CurrentInvoiceModel({
    @JsonKey(name: 'total_after')
    required String totalAfter,
    @JsonKey(name: 'total_before')
    required String totalBefore,
    @JsonKey(name: 'cut_date')
    required String cutDate,
    @JsonKey(name: 'limit_date')
    required String limitDate,
    @JsonKey(name: 'id_bill')
    required String idBill,
    @JsonKey(name: 'status_bill')
    required String statusBill,
    @JsonKey(name: 'flag_listprice')
    required String flagListprice,
    @JsonKey(name: 'day_pay')
    required String dayPay,
    @JsonKey(name: 'id_client')
    required String idClient,
    @JsonKey(name: 'name_client')
    required String nameClient,
    @JsonKey(name: 'status_client')
    required String statusClient,
  }) = _CurrentInvoiceModel;

  factory CurrentInvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentInvoiceModelFromJson(json);
}