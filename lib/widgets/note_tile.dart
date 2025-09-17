import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/helpers.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
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
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.fromFigmaWidth(context, 41),
          vertical: ResponsiveSize.fromFigmaHeight(context, 21),
        ),
        child: Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: ResponsiveSize.responsiveFontSize(context, 25),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
