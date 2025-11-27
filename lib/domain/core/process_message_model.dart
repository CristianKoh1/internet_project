import 'package:moloch_app/domain/core/extra_data_model.dart';
import 'package:moloch_app/domain/enums/kyc_status_type.dart';

class ProcessMessageModel {
  final Kyc_status_type type;
  final ExtraData extraData;

  ProcessMessageModel({
    required this.type,
    required this.extraData,
  });

  factory ProcessMessageModel.fromJson(Map<String, dynamic> json) {
    return ProcessMessageModel(
      type:
           Kyc_status_type.values.firstWhere((e) => e.value == json['message']),
      extraData: ExtraData.fromJson(json['extraData']),
    );
  }

  factory ProcessMessageModel.fromJsonWeb(Map<String, dynamic> json) {
    return ProcessMessageModel(
      type:
          Kyc_status_type.values.firstWhere((e) => e.value == json['code']),
      extraData: ExtraData.fromJson(json),
    );
  }

  Map<String, Object> toJson() {
    if (type == Kyc_status_type.completed) {
      return {
        'type': Kyc_status_type.completed.value,
        'code': extraData.code,
        'message': extraData.message,
      };
    }
    if (type == Kyc_status_type.canceled) {
      return {
        'type': Kyc_status_type.canceled.value,
        'code': extraData.code,
        'message': extraData.message,
      };
    }
    if (type == Kyc_status_type.signed) {
      return {
        'type': Kyc_status_type.signed.value,
        'code': extraData.code,
        'info_code': extraData.infoEvent!.code,
        'info_detail': extraData.infoEvent!.detail,
      };
    }
    if (type == Kyc_status_type.processEvents) {
      return {
        'type': Kyc_status_type.processEvents.value,
        'code': extraData.code,
        'message': extraData.message,
        'info_code': extraData.infoEvent!.code,
        'info_message': extraData.infoEvent!.detail,
      };
    }
    if (type == Kyc_status_type.error) {
      return {
        'type': Kyc_status_type.error.value,
        'code': extraData.code,
        'message': extraData.message,
        'stage': extraData.stage!,
      };
    }
    return {
      'type': Kyc_status_type.error.value,
      'code': extraData.code,
      'message': extraData.message
    };
  }
}
