import 'package:moloch_app/domain/core/extra_data_model.dart';

class ProcessMessage {
  final String message;
  final ExtraData extraData;

  ProcessMessage({
    required this.message,
    required this.extraData,
  });

  factory ProcessMessage.fromJson(Map<String, dynamic> json) {
    return ProcessMessage(
      message: json['message'],
      extraData: ExtraData.fromJson(json['extraData']),
    );
  }
}