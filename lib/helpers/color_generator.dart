import 'dart:math';

import 'package:flutter/material.dart';

class ColorGenerator {
  static Color getPastelColor() {
    final random = Random();
    final hsl = HSLColor.fromAHSL(
      1.0, // Альфа
      random.nextDouble() * 360, // Оттенок: весь спектр
      0.5 + random.nextDouble() * 0.3, // Насыщенность: 0.4–0.7
      0.65 + random.nextDouble() * 0.15, // Яркость: 0.85–0.95
    );
    return hsl.toColor();
  }
}
