enum SalarySchemeType {
  weekly(value: "SEMANA"),
  biweekly(value: "QUINCENA"),
  monthly(value: "MES");

  final String value;

  const SalarySchemeType({
    required this.value,
  });
}
