enum PaymentFrequencyType {
  fortnight(value: "QUINCENAL");

  final String value;

  const PaymentFrequencyType({
    required this.value,
  });
}