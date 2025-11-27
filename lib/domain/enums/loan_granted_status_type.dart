enum LoanGrantedStatusType {
  noSignature(value: "SIN_FIRMA", number:0),
  active(value: "ACTIVO", number:1),
  paid(value: "PAGADO", number:2),
  canceled(value: "CANCELADO", number:3);

  final String value;
  final int number;

  const LoanGrantedStatusType({
    required this.value,
    required this.number,
  });
}
