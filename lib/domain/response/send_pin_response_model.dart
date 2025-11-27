import 'package:freezed_annotation/freezed_annotation.dart';
part 'send_pin_response_model.freezed.dart';
part 'send_pin_response_model.g.dart';

@freezed
abstract class SendPinResponseModel with _$SendPinResponseModel {
  const factory SendPinResponseModel({
    @Default('') String id,
    @Default('') String phone,
  }) = _SendPinResponseModel;

  factory SendPinResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SendPinResponseModelFromJson(json);
}
