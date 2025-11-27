import 'package:freezed_annotation/freezed_annotation.dart';
part 'factura_model.freezed.dart';
part 'factura_model.g.dart';

@freezed
abstract class FacturaModel with _$FacturaModel {
  const factory FacturaModel({
    @Default('') String total,
    @Default('') String impuesto,
    @Default('') String otrosImpuestos,
    @Default('') String id,
    @Default('') String emitido,
    @Default('') String vencimiento,
    @Default('') String nombre,
    @Default('') String direccionPrincipal,
    @Default('') String telefono,
    @Default('') String movil,
  }) = _FacturaModel;

  factory FacturaModel.fromJson(Map<String, dynamic> json) => _$FacturaModelFromJson(json);
}