enum Kyc_status_type {
  completed(value: 'ProcessCompleted'),
  canceled(value: 'ProcessCancelled'),
  signed(value: 'ProcessSigned'),
  rejected(value: 'ProcessSignatureRejected'),
  processEvents(value: 'ProcessEvents'),
  error(value: 'error');

  final String value;

  const Kyc_status_type({
    required this.value,
  });
  static Kyc_status_type getStatus(String status,{bool isWeb = false}) {
    return Kyc_status_type.values.firstWhere(
      (_status) {
        final value = isWeb ? _status.value : _status.name;
        return value == status;
      },
      orElse: () => processEvents,
    );
  }
}
