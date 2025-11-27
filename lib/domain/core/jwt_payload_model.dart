import 'package:moloch_app/domain/core/extension/string_extension.dart';

class JwtPayloadModel {
    final String userName;
    final String email;
    final String userId;

    JwtPayloadModel({
        required this.userName,
        required this.email,
        required this.userId,
    });

    factory JwtPayloadModel.fromJson(Map<String, dynamic> json) => JwtPayloadModel(
        userName: json["UserName"].toString().sanitize(),
        email: json["Email"].toString().sanitize(),
        userId: json["UserID"],
    );
}