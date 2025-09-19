import 'dart:developer';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/database/note/note_database.dart';
import 'package:notes_app/helpers/color_generator.dart';
import 'package:notes_app/widgets/app_bar_button.dart';

import '../../../bloc/note_bloc/bloc/note_bloc.dart';
import '../../../helpers/helpers.dart';
import '../widgets/widgets.dart';

class CreateScreen extends StatelessWidget {
  final Note? note;
  const CreateScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController titleEditingController =
        TextEditingController(text: note?.title ?? '');
    final TextEditingController textEditingController =
        TextEditingController(text: note?.body ?? '');

    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xff252525),
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
                  floating: true,
                  pinned: true,
                  actions: [
                    AppBarButton(
                      icon: Icons.arrow_back,
                      onTap: Navigator.of(context).pop,
                    ),
                    Spacer(),
                    AppBarButton(icon: Icons.looks, onTap: () {}),
                    SizedBox(
                      width: ResponsiveSize.fromFigmaWidth(
                        context,
                        21,
                      ),
                    ),
                    AppBarButton(
                      icon: Icons.save,
                      onTap: () {
                        _saveNote(
                          formKey: formKey,
                          titleEditingController:
                              titleEditingController,
                          textEditingController:
                              textEditingController,
                          context: context,
                          note: note,
                        );
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: ResponsiveSize.fromFigmaHeight(
                      context,
                      5,
                    ),
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
                          textEditingController:
                              titleEditingController,
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
                          textEditingController:
                              textEditingController,
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
      },
    );
  }

  void _saveNote({
    required GlobalKey<FormState> formKey,
    required TextEditingController titleEditingController,
    required TextEditingController textEditingController,
    required BuildContext context,
    required Note? note,
  }) {
    if (!formKey.currentState!.validate()) return;
    final String title = titleEditingController.text.trim();
    final String body = textEditingController.text.trim();

    if (note != null) {
      final newNote = Note(
        id: note.id,
        title: title,
        body: body,
        createAt: note.createAt,
        colorValue: note.colorValue,
      );
      context.read<NoteBloc>().add(UpdateNoteEvent(note: newNote));
    } else {
      final color = ColorGenerator.getPastelColor().toARGB32();
      final newNote = NotesCompanion.insert(
        title: title,
        body: body,
        createAt: DateTime.timestamp(),
        colorValue: Value(color),
      );
      context.read<NoteBloc>().add(AddNoteEvent(note: newNote));
    }

    Navigator.of(context).pop();
  }
}
