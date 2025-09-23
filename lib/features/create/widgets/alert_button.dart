import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/helpers.dart';

class AlertButton extends StatelessWidget {
  const AlertButton({
    super.key,
    required this.color,
    required this.text,
    required this.onTap,
  });
  final Color color;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentGeometry.center,
        width: ResponsiveSize.fromFigmaWidth(context, 112),
        height: ResponsiveSize.fromFigmaHeight(context, 39),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: ResponsiveSize.responsiveFontSize(context, 16),
          ),
        ),
      ),
    );
  }
}
