enum LoanGrantedBannerStatusType {
  counteroffer(value: 'CONTRAOFERTA', number: 0),
  deposit(value: 'DEPOSITO', number: 1),
  uploading_documents(value: 'CARGANDO_DOCUMENTOS', number: 2),
  documents_uploaded(value: 'DOCUMENTOS_CARGADOS', number: 3),
  sig_documents(value: 'FIRMANDO_DOCUMENTOS', number: 4),
  read_documents(value: 'LEER_DOCUMENTOS', number: 5),
  completed(value: 'COMPLETADO', number: 6),
  terms_conditions(value: 'TERMINOS_CONDICIONES', number: 7),
  kyc(value: 'KYC', number: 8),
  verify_identity(value: 'VERIFICAR_IDENTIDAD', number: 9),;

  final String value;
  final int number;

  const LoanGrantedBannerStatusType({
    required this.value,
    required this.number,
  });
}
