import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/bloc/note_bloc/bloc/note_bloc.dart';
import 'package:notes_app/features/create/view/create_screen.dart';
import 'package:notes_app/helpers/responsive_size.dart';

import '../../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xff252525),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create_new_note');
            },
            backgroundColor: Color(0xff252525),
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: Padding(
            padding:
                EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.fromFigmaWidth(
                    context,
                    21,
                  ),
                ).copyWith(
                  top: ResponsiveSize.fromFigmaHeight(context, 15),
                ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Noter',
                    style: GoogleFonts.nunito(
                      fontSize: ResponsiveSize.responsiveFontSize(
                        context,
                        43,
                      ),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  floating: true,
                  actions: [
                    AppBarButton(
                      icon: Icons.search,
                      onTap: () {
                        Navigator.pushNamed(context, '/search_note');
                      },
                    ),
                    SizedBox(
                      width: ResponsiveSize.fromFigmaWidth(
                        context,
                        21,
                      ),
                    ),
                    AppBarButton(
                      icon: Icons.info_outline_rounded,
                      onTap: () {},
                    ),
                  ],
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
                if (state is NoteEmptyState)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('images/rafiki.png'),
                          Text(
                            'Create your first note!',
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
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: ResponsiveSize.fromFigmaHeight(
                      context,
                      21,
                    ),
                  ),
                ),
                if (state is NoteLoadedState)
                  SliverList.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final currentState = state;
                      final notes = currentState.notes;
                      final note = notes[index];
                      final color = note.colorValue;
                      final title = note.title;
                      final id = note.id;
                      return NoteTile(
                        onLongPress: () {
                          context.read<NoteBloc>().add(
                            DeleteNoteEvent(id: id),
                          );
                        },
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
