import 'dart:convert';

import 'package:flutter/foundation.dart';

class DocumentResponseModel {
  final String type;
  final Uint8List document;

  DocumentResponseModel({
    required this.type,
    required this.document,
  });

  factory DocumentResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      DocumentResponseModel(
        type: json["type"],
        document: base64Decode(json["document"] as String),
      );
}
