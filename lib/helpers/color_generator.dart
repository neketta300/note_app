import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    256,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
