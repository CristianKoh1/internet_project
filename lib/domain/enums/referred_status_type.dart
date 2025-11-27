enum ReferredStatusType {
  invited(value: "INVITADO"),
  completed(value: "COMPLETADO");

  final String value;

  const ReferredStatusType({
    required this.value,
  });
}