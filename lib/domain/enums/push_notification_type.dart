enum PushNotificationType {
  updatedApplication(value: "SOLICITUD_ACTUALIZADA"),
  unknown(value: "DESCONOCIDO");

  final String value;
  
  const PushNotificationType({
    required this.value,
  });
}