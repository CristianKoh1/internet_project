class LocaleService {
  static final LocaleService _instance = LocaleService._internal();

  factory LocaleService() => _instance;

  LocaleService._internal();

  String _localeName = 'en'; // Valor por defecto

  String get localeName => _localeName;

  void setLocale(String locale) {
    _localeName = locale;
  }
}