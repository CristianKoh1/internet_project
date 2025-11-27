enum EnviromentType {
  dev(value: "dev"),
  local(value: "local"),
  prod(value: "prod");

  final String value;
  
  const EnviromentType({
    required this.value,
  });
}
