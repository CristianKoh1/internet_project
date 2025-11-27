extension DoubleExtension on double? {
  static final int _oneHundred = 100;

  double convertPercentageToDouble() {
    final doubleValue = this;

    if (doubleValue == null) return 0.0;

    return doubleValue / _oneHundred;
  }
}
