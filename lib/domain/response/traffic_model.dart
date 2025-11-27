class TrafficModel {
  final String mes;
  final String subida;
  final String descarga;

  TrafficModel({
    required this.mes,
    required this.subida,
    required this.descarga,
  });

  factory TrafficModel.fromJson(Map<String, dynamic> json) {
    return TrafficModel(
      mes: json['mes'] as String,
      subida: json['subida'] as String,
      descarga: json['descarga'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'mes': mes,
        'subida': subida,
        'descarga': descarga,
      };
}