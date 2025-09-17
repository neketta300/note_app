import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/widgets/app_bar_button.dart';

import '../../../helpers/helpers.dart';

class CreateScreen extends StatelessWidget {
  final String? title;
  final String? text;
  const CreateScreen({super.key, this.title, this.text});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController titleEditingController =
        TextEditingController();
    final TextEditingController textEditingController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.fromFigmaWidth(context, 21),
        ).copyWith(top: ResponsiveSize.fromFigmaHeight(context, 15)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              pinned: true,
              actions: [
                AppBarButton(
                  icon: Icons.arrow_back,
                  onTap: Navigator.of(context).pop,
                ),
                Spacer(),
                AppBarButton(icon: Icons.looks, onTap: null),
                SizedBox(
                  width: ResponsiveSize.fromFigmaWidth(context, 21),
                ),
                AppBarButton(icon: Icons.save, onTap: () {}),
              ],
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: ResponsiveSize.fromFigmaHeight(context, 40),
              ),
            ),

            SliverToBoxAdapter(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CreateNoteTextField(
                      hintSize: 48,
                      textSize: 38,
                      hintText: 'Title',
                      textEditingController: titleEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          log('Введите заголов');
                        }
                        return null;
                      },
                      autofocus: true,
                    ),

                    SizedBox(
                      height: ResponsiveSize.fromFigmaHeight(
                        context,
                        20,
                      ),
                    ),

                    CreateNoteTextField(
                      hintSize: 23,
                      textSize: 23,
                      hintText: 'Type something...',
                      textEditingController: textEditingController,
                      autofocus: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateNoteTextField extends StatelessWidget {
  const CreateNoteTextField({
    super.key,
    required this.hintSize,
    required this.textSize,
    required this.hintText,
    required this.textEditingController,
    required this.autofocus,
    this.validator,
  });
  final TextEditingController textEditingController;
  final double hintSize;
  final double textSize;
  final String hintText;
  final bool autofocus;
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
