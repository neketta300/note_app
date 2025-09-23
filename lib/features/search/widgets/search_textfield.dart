import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/bloc/note_bloc/bloc/note_bloc.dart';

import '../../../helpers/helpers.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Color(0xff9A9A9A),
            selectionHandleColor: Color(0xff9A9A9A),
          ),
        ),
        child: TextField(
          onChanged: (value) {
            context.read<NoteBloc>().add(
              SearchNotesEvent(query: value),
            );
          },
          controller: searchController,
          cursorColor: Color(0xff9A9A9A),
          style: GoogleFonts.nunito(
            fontSize: ResponsiveSize.responsiveFontSize(context, 20),
            fontWeight: FontWeight.w300,
            color: Color(0xffCCCCCC),
          ),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                context.read<NoteBloc>().add(LoadNoteEvent());
                Navigator.of(context).pop();
              },
              child: Icon(Icons.cancel, color: Color(0xffCCCCCC)),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: ResponsiveSize.responsiveFontSize(
                context,
                30,
              ),
            ),
            filled: true,
            fillColor: Color(0xff3B3B3B),
            hintText: 'Search by the keyword...',
            hintStyle: GoogleFonts.nunito(
              color: Color(0xFFCCCCCC),
              fontWeight: FontWeight.w300,
              fontSize: ResponsiveSize.responsiveFontSize(
                context,
                20,
              ),
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
