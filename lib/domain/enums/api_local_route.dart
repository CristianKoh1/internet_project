enum ApiLocalRoutes {
  auth(
    port: ":7144",
    microservice: 'usuarios',
  ),
  account(
    port: ":7241",
    microservice: 'account',
  ),
  common(
    port: ':7223',
    microservice: 'common',
  ),
  contacto(
    port: ':7154',
    microservice: 'contacto',
  ),
  wallet(
    port: ':7031',
    microservice: 'tarjetasService',
  ),
  notification(
    port: ':5001',
    microservice: 'notification',
  ),
  ;

  final String port;
  final String microservice;
  const ApiLocalRoutes({
    required this.port,
    required this.microservice,
  });
}
