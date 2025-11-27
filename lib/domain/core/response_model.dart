

import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_model.freezed.dart';

@freezed
abstract class ResponseModel<T> with _$ResponseModel<T> {
  const factory ResponseModel({
    required bool status,
    String? message,
    required T? data,
  }) = _ResponseModel<T>;

  factory ResponseModel.fromJson(
      {required Map<String, dynamic> json,
      required T Function(dynamic) fromJsonT}) {
    return ResponseModel<T>(
      status: json['status'] as bool,
      message: json['message'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}