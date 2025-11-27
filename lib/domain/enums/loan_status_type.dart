enum LoanStatusType {
  pending(value: "PENDIENTE"),
  checkingCreditBureau(value: "REVISANDO_BURO"),
  bureauApproved(value: "BURO_APROBADO"),
  preApproved(value: "PRE_APROBADO"),
  approvedByUser(value: "APROBADO_POR_USUARIO"),
  approvedByDesk(value: "APROBADO_POR_MESA"),
  complete(value: "COMPLETADO"),
  offerAccepted(value: "OFERTA_ACEPTADA"),
  rejected(value: "RECHAZADO");

  final String value;

  const LoanStatusType({
    required this.value,
  });
}
