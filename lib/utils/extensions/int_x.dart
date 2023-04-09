import 'dart:math';

extension BytesToMegabytesX on int {
  String toMegabytes() => (this / pow(1024, 2)).toStringAsFixed(2);
}
