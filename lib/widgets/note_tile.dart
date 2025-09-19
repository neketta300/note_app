import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/helpers.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.color,
    required this.text,
    required this.onTap,
    required this.onLongPress,
  });

  final int color;
  final String text;
  final void Function() onTap;
  final void Function() onLongPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
          bottom: ResponsiveSize.fromFigmaHeight(context, 20),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.fromFigmaWidth(context, 41),
          vertical: ResponsiveSize.fromFigmaHeight(context, 21),
        ),
        child: Text(
          text,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveSize.responsiveFontSize(context, 25),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
