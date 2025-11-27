import 'package:freezed_annotation/freezed_annotation.dart';
part 'has_password_response_model.freezed.dart';

@freezed
abstract class HasPasswordResponseModel with _$HasPasswordResponseModel {
  const factory HasPasswordResponseModel({
    @Default(false) bool hasPassword,
  }) = _HasPasswordResponseModel;

  factory HasPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return HasPasswordResponseModel(
      hasPassword: json['has_password_portal'] ?? false,
    );
  }
}
