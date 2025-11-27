import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_model.freezed.dart';
part 'invoice_model.g.dart';

@freezed
abstract class InvoiceModel with _$InvoiceModel {
  const factory InvoiceModel({
    required String id,
    required String legal,
    required String emitido,
    required String vencimiento,
    required String estado,
    required String total,
    required String impuesto,
    required String tipo,
    required String cobrado,
    required String? pago,
    required String forma,
  }) = _InvoiceModel;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);
}