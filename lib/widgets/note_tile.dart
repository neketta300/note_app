import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/helpers.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({
    super.key,
    required this.color,
    required this.text,
    required this.onTap,
    required this.onSecondTap,
  });

  final int color;
  final String text;
  final void Function() onTap;
  final void Function() onSecondTap;

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  bool isSelcted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isSelcted = !isSelcted;
        });
      },
      onTap: () {
        if (isSelcted) {
          widget.onSecondTap();
          isSelcted = !isSelcted;
        } else {
          widget.onTap();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelcted ? Colors.red : Color(widget.color),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
          bottom: ResponsiveSize.fromFigmaHeight(context, 20),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.fromFigmaWidth(context, 41),
          vertical: ResponsiveSize.fromFigmaHeight(context, 21),
        ),
        child: Stack(
          children: [
            Text(
              widget.text,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveSize.responsiveFontSize(
                  context,
                  25,
                ),
                color: Colors.black,
              ),
            ),
            if (isSelcted)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      size: 34,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
