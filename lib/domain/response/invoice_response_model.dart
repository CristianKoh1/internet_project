import 'package:freezed_annotation/freezed_annotation.dart';
import 'factura_model.dart';
import 'item_model.dart';
import 'emisor_model.dart';

part 'invoice_response_model.freezed.dart';
part 'invoice_response_model.g.dart';

@freezed
abstract class InvoiceResponseModel with _$InvoiceResponseModel {
  const factory InvoiceResponseModel({
    required FacturaModel factura,
    required List<ItemModel> items,
    required List<EmisorModel> emisor,
    @Default(0) int descuento,
  }) = _InvoiceResponseModel;

  factory InvoiceResponseModel.fromJson(Map<String, dynamic> json) => _$InvoiceResponseModelFromJson(json);
}