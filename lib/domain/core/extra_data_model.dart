import 'package:moloch_app/domain/core/process_event_info_model.dart';

class ExtraData {
  final String type;
  final String code;
  final String message;
  final ProcessEventInfoModel? infoEvent;
  final String? stage;

  ExtraData({
    required this.type,
    required this.code,
    required this.message,
    this.infoEvent,
    this.stage,
  });

  Map<String, Object?> toJson() {
    return {
      'type': type,
      'code': code,
      'message': message,
      'stage': stage,
      'infoEvent': infoEvent?.toJson(),
    };
  }

  factory ExtraData.fromJson(Map<String, dynamic> json) {
    return ExtraData(
      type: json['type'],
      code: json['code'],
      message: json['message'],
      stage: json['stage'],
      infoEvent: json['infoEvent'] == null
          ? null
          : ProcessEventInfoModel.fromJson(json['infoEvent']),
    );
  }
}
