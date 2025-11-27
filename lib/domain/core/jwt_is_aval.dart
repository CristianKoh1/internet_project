

class IsAvalModel {
  final bool? isAval;


  IsAvalModel({
    required this.isAval,

  });

  factory IsAvalModel.fromJson(Map<String, dynamic> json) =>
      IsAvalModel(
        isAval: json["IsAval"] == null ? null : bool.parse(json["IsAval"]),
      
      );
}
