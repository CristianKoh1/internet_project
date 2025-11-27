class FirebaseCrashlytics {
  static FirebaseCrashlytics get instance => FirebaseCrashlytics();

  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) async {}

  Future<void> recordFlutterFatalError(
    FlutterErrorDetails flutterErrorDetails, {
    bool fatal = true,
  }) async {}

  Future<void> setUserIdentifier(String identifier) async {}

  Future<void> log(String message) async {}
  
  Future<void> setCustomKey(
    String key,
    Object value,
  ) async {}

  Future<void> sendUnsentReports() async {}
}

typedef FlutterErrorDetails = dynamic;
