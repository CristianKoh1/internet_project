import 'package:freezed_annotation/freezed_annotation.dart';
part 'emisor_model.freezed.dart';
part 'emisor_model.g.dart';

@freezed
abstract class EmisorModel with _$EmisorModel {
  const factory EmisorModel({
    @Default('') String id,
    @Default('') String setting,
    @Default('') String value,
  }) = _EmisorModel;

  factory EmisorModel.fromJson(Map<String, dynamic> json) => _$EmisorModelFromJson(json);
}