import 'dart:developer';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/database/note/note_database.dart';

import '../../../bloc/note_bloc/bloc/note_bloc.dart';
import '../../../helpers/helpers.dart';
import '../../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class CreateScreen extends StatefulWidget {
  final bool editStatus;
  final Note? note;
  const CreateScreen({
    super.key,
    this.note,
    required this.editStatus,
  });

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late bool currentEditStatus;
  late String initialTitle;
  late String initialBody;

  late TextEditingController titleEditingController;
  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    currentEditStatus = widget.editStatus;

    initialTitle = widget.note?.title ?? '';
    initialBody = widget.note?.body ?? '';

    titleEditingController = TextEditingController(
      text: initialTitle,
    );
    textEditingController = TextEditingController(text: initialBody);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, results) async {
        if (didPop) return;
        final hasChanges =
            titleEditingController.text.trim() !=
                initialTitle.trim() ||
            textEditingController.text.trim() != initialBody.trim();

        if (hasChanges) {
          final shouldExit = await _showExitDialog(context);
          if (shouldExit) Navigator.of(context).pop();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<NoteBloc, NoteState>(
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
                        onTap: () {
                          Navigator.maybePop(context);
                        },
                      ),
                      Spacer(),
                      currentEditStatus
                          ? Row(
                              children: [
                                AppBarButton(
                                  icon: Icons.looks,
                                  onTap: () {
                                    currentEditStatus =
                                        !currentEditStatus;
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  width:
                                      ResponsiveSize.fromFigmaWidth(
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
                                      note: widget.note,
                                    );
                                  },
                                ),
                              ],
                            )
                          : AppBarButton(
                              icon: Icons.edit,
                              onTap: () {
                                setState(() {
                                  currentEditStatus =
                                      !currentEditStatus;
                                });
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
                            enabled: currentEditStatus,
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
                            enabled: currentEditStatus,
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
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Color(0xff252525),
            title: Icon(
              Icons.info,
              color: Color(0xff606060),
              size: 32,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Выйти без сохранения?',
                  maxLines: 1,
                  style: GoogleFonts.nunito(
                    color: Color(0xffCFCFCF),
                    fontSize: 23,
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertButton(
                    color: Colors.red,
                    text: 'Выйти',
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                  SizedBox(
                    width: ResponsiveSize.fromFigmaWidth(context, 35),
                  ),
                  AlertButton(
                    color: Colors.green,
                    text: 'Остаться',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false;
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
      initialBody = body;
      initialTitle = title;
    } else {
      final color = ColorGenerator.getPastelColor().toARGB32();
      final newNote = NotesCompanion.insert(
        title: title,
        body: body,
        createAt: DateTime.timestamp(),
        colorValue: Value(color),
      );
      context.read<NoteBloc>().add(AddNoteEvent(note: newNote));
      initialBody = body;
      initialTitle = title;
    }
  }
}
