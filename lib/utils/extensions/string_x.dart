extension TrailingZerosX on String {
  String get removeTrailingZeros {
    if (this == '0') return this;
    final regex = RegExp(r'([.]*0+)(?!.*\d)');
    return replaceAll(regex, '');
  }
}
