import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/helpers.dart';

class CreateNoteTextField extends StatelessWidget {
  const CreateNoteTextField({
    super.key,
    required this.hintSize,
    required this.textSize,
    required this.hintText,
    required this.textEditingController,
    required this.autofocus,
    required this.enabled,
    this.validator,
  });
  final TextEditingController textEditingController;
  final double hintSize;
  final double textSize;
  final String hintText;
  final bool autofocus;
  final bool enabled;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color(0xff9A9A9A),
          selectionHandleColor: Color(0xff9A9A9A),
        ),
      ),
      child: TextFormField(
        enabled: enabled,
        maxLines: null,
        minLines: 1,
        autofocus: autofocus,
        controller: textEditingController,
        validator: validator,
        cursorColor: Color(0xff9A9A9A),
        style: GoogleFonts.nunito(
          fontSize: ResponsiveSize.responsiveFontSize(
            context,
            textSize,
          ),
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.nunito(
            fontSize: ResponsiveSize.responsiveFontSize(
              context,
              hintSize,
            ),
            color: Color(0xff9A9A9A),
          ),
        ),
      ),
    );
  }
}
