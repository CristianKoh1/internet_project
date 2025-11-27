class ProcessEventInfoModel {
  final String code;
  final String detail;

  ProcessEventInfoModel({
    required this.code,
    required this.detail,
  });

  Map<String, Object> toJson() {
    return {
      'code': code,
      'detail': detail,
    };
  }

  factory ProcessEventInfoModel.fromJson(Map<String, dynamic> json) {
    return ProcessEventInfoModel(
      code: json['code'],
      detail: json['detail'],
    );
  }
}