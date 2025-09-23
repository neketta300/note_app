import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/bloc/note_bloc/bloc/note_bloc.dart';
import 'package:notes_app/helpers/responsive_size.dart';

import '../../../widgets/widgets.dart';
import '../../create/view/create_screen.dart';
import '../search.dart';

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
                SearchTextfield(searchController: searchController),
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
                      final id = note.id;
                      return NoteTile(
                        color: color,
                        text: title,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CreateScreen(
                                note: note,
                                editStatus: false,
                              ),
                            ),
                          );
                        },
                        onSecondTap: () {
                          context.read<NoteBloc>().add(
                            DeleteNoteEvent(id: id),
                          );
                        },
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
