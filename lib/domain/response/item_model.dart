import 'package:freezed_annotation/freezed_annotation.dart';
part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
abstract class ItemModel with _$ItemModel {
  const factory ItemModel({
    @Default('') String descripcion,
    @Default('') String cantidad,
    @Default('') String unidades,
    @Default('') String impuesto,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);
}