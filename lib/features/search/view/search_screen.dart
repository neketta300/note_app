import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/bloc/note_bloc/bloc/note_bloc.dart';
import 'package:notes_app/helpers/responsive_size.dart';

import '../../../widgets/widgets.dart';
import '../../create/view/create_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController searchController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoteBloc>().add(StartSearchEvent());
    });

    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xff252525),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: ResponsiveSize.fromFigmaHeight(
                      context,
                      88,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme:
                          const TextSelectionThemeData(
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
                        fontSize: ResponsiveSize.responsiveFontSize(
                          context,
                          20,
                        ),
                        fontWeight: FontWeight.w300,
                        color: Color(0xffCCCCCC),
                      ),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            context.read<NoteBloc>().add(
                              LoadNoteEvent(),
                            );
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Color(0xffCCCCCC),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              ResponsiveSize.responsiveFontSize(
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
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: ResponsiveSize.fromFigmaHeight(
                      context,
                      21,
                    ),
                  ),
                ),
                if (state is SearchInitialState)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Start typing to search...',
                            style: GoogleFonts.nunito(
                              fontSize:
                                  ResponsiveSize.responsiveFontSize(
                                    context,
                                    20,
                                  ),
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (state is NoteLoadingState)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (state is NoteLoadedState)
                  SliverList.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final notes = state.notes;
                      final note = notes[index];
                      final title = note.title;
                      final color = note.colorValue;
                      return NoteTile(
                        color: color,
                        text: title,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CreateScreen(note: note),
                            ),
                          );
                        },
                        onLongPress: () {},
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
