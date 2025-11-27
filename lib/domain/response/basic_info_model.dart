import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_info_model.freezed.dart';
part 'basic_info_model.g.dart';

@freezed
abstract class BasicInfoModel with _$BasicInfoModel {
  const factory BasicInfoModel({
    required String name,
    String? alias,
    required String phone,
    required String email,
  }) = _BasicInfoModel;

  factory BasicInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoModelFromJson(json);
}