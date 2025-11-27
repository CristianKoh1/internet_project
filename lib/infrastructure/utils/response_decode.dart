import 'dart:convert';
import 'package:http/http.dart';
import 'package:moloch_app/domain/core/response_model.dart';
/// Decodifica la respuesta HTTP [response] en un modelo genérico [T].
///
/// Toma un [response] de tipo [Response] y una función [fromJson] que convierte
/// el JSON dinámico en un tipo específico [T].
///
/// Retorna un modelo [ResponseModel] que encapsula el JSON decodificado [json]
/// y el resultado de aplicar la función [fromJson] al JSON decodificado.
ResponseModel responseDecode<T>(
    Response response, T Function(dynamic) fromJson) {
  final json = jsonDecode(response.body);
  return ResponseModel.fromJson(
    json: json,
    fromJsonT: fromJson,
  );
}
