enum PdfPreviewType {
  jointGuarantees(value: 'AVALISTAS_SOLIDARIOS'),
  authorizationAdminExpenses(value: 'AUTORIZACION_GASTOS_ADMON'),
  legalProvision(value: 'DISPOSICION_LEGAL'),
  privacyNotice(value: 'AVISO_PRIVACIDAD'),
  complementaryServices(value: 'SERVICIOS_COMPLEMENTARIOS'),
  promissoryNote(value: 'PAGARE'),
  amortizationTable(value: 'TABLA_AMORTIZACION'),
  creditCover(value: 'CARATULA_CREDITO'),
  creditApplication(value: 'SOLICITUD_CREDITO'),
  contract(value: 'CONTRATO'),
  deathConsent(value: 'CONSENTIMIENTO_FALLECIMIENTO'),
  funeralConsent(value: 'CONSENTIMIENTO_FUNERARIO'),
  healthQuestionnaire(value: 'CUESTIONARIO_SALUD'),
  personalAccidents(value: 'ACCIDENTES_PERSONALES'),
  cosignerContract(value: 'CONTRATO_PAGARE_AVAL'),
  smsAuthorizationv(value: 'PERMISO_SMS');
  
  final String value;

  const PdfPreviewType({
    required this.value,
  });
}
