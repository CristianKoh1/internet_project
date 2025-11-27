enum OperationFailureError {
  opps(value: "OPPS");

  final String value;

  const OperationFailureError({required this.value});

  String getMessage() {
    return value;
  }
}
