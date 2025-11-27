import 'dart:convert';

class MetadataModel {
  final String fingerPrint;
  final String? metadata;

  MetadataModel({required this.fingerPrint, required this.metadata});

  Map<String, dynamic> toJson() {
    return {
      'date': DateTime.now().toIso8601String(),
      'fingerPrint': fingerPrint,
      'metadata': metadata,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}