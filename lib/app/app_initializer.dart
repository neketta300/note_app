import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/app/app_config.dart';
import 'package:notes_app/bloc/note_bloc/bloc/note_bloc.dart';
import 'package:notes_app/repositories/note/note_repository.dart';
import 'package:notes_app/repositories/note/note_repository_interface.dart';

class AppInitializer extends StatelessWidget {
  final Widget child;
  final AppConfig appConfig;

  const AppInitializer({
    super.key,
    required this.appConfig,
    required this.child,
  });

  @override
  Widget build(Object context) {
    return RepositoryProvider<NoteRepositoryI>(
      create: (context) => NoteRepository(db: appConfig.noteDatabase),
      child: BlocProvider(
        create: (context) =>
            NoteBloc(noteRepository: context.read<NoteRepositoryI>())
              ..add(LoadNoteEvent()),
        child: child,
      ),
    );
  }
}
