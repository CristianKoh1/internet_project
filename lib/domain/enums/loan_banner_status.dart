enum LoanBannerStatusType {
  start(value: 'INICIO'),
  terms_conditions(value: 'TERMINOS_CONDICIONES'),
  kyc(value: 'KYC'),
  verify_identity(value: 'VERIFICAR_IDENTIDAD'),
  personal_information(value: 'DATOS_PERSONALES'),
  address(value: 'DIRECCION'),
  financial_information(value: 'INFORMACION_FINANCIERA'),
  beneficiary(value: 'BENEFICIARIOS'),
  authorize_buro(value: 'AUTORIZAR_BURO'),
  checking_bureau(value: 'REVISANDO_BURO'),
  pre_approved(value: 'PRE_APROBADO'),
  vouchers(value: 'COMPROBANTES'),
  references(value: 'REFERENCIAS'),
  pld(value: 'PLD'),
  summary(value: 'RESUMEN'),
  filled(value: 'COMPLETADO'),
  rejected(value: 'RECHAZADO');
  
  final String value;

  const LoanBannerStatusType({
    required this.value,
  });
}
