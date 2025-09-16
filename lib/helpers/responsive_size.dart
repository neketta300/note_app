import 'package:flutter/material.dart';

class ResponsiveSize {
  static const double figmaWidth = 414;
  static const double figmaHeight = 1100;

  static double fromFigmaWidth(
    BuildContext context,
    double figmaValue,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (figmaValue / figmaWidth);
  }

  static double fromFigmaHeight(
    BuildContext context,
    double figmaValue,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * (figmaValue / figmaHeight);
  }

  static double responsiveFontSize(
    BuildContext context,
    double figmaFontSize,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (figmaFontSize / figmaWidth);
  }
}
