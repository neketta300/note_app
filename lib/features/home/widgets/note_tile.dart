import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../helpers/helpers.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.onTap,
    required this.title,
  });
  final void Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.fromFigmaWidth(context, 41),
          vertical: ResponsiveSize.fromFigmaHeight(context, 21),
        ),
        child: Text(
          title,
          style: GoogleFonts.nunito(
            fontSize: ResponsiveSize.responsiveFontSize(context, 25),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
