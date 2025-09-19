import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/repositories/note/note_repository_interface.dart';

import '../../../database/note/note_database.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepositoryI _noteRepository;
  StreamSubscription<List<Note>>? _noteSubscription;

  NoteBloc({required NoteRepositoryI noteRepository})
    : _noteRepository = noteRepository,
      super(NoteInitialState()) {
    on<NoteEvent>((event, emit) {});
    on<LoadNoteEvent>((event, emit) async {
      emit(NoteLoadingState());
      _noteSubscription?.cancel();
      // Как только придёт новый список заметок — добавь в блок событие _NotesUpdatedEvent
      _noteSubscription = _noteRepository.watchAllNotes().listen(
        (notes) {
          add(_NotesUpdatedEvent(notes));
        },
        onError: (error) {
          emit(
            NoteErrorState(message: 'Ошибка при получении заметок'),
          );
        },
      );
    });

    on<_NotesUpdatedEvent>((event, emit) {
      if (event.notes.isEmpty) {
        emit(NoteEmptyState());
      } else {
        emit(NoteLoadedState(notes: event.notes));
      }
    });

    on<StartSearchEvent>((event, emit) {
      emit(SearchInitialState());
    });

    on<DeleteNoteEvent>((event, emit) async {
      try {
        await _noteRepository.deleteNote(event.id);
      } catch (e) {
        emit(NoteErrorState(message: 'Ошибка удаления заметки'));
      }
    });

    on<AddNoteEvent>((event, emit) async {
      try {
        await _noteRepository.addNote(event.note);
        add(LoadNoteEvent());
      } catch (e) {
        emit(NoteErrorState(message: 'Ошибка сохранения заметки'));
      }
    });

    on<UpdateNoteEvent>((event, emit) async {
      try {
        await _noteRepository.updateNote(event.note);
        add(LoadNoteEvent());
      } catch (e) {
        emit(NoteErrorState(message: 'Ошибка изменения заметки'));
      }
    });

    on<SearchNotesEvent>((event, emit) async {
      emit(NoteLoadingState());
      try {
        final query = event.query.trim();
        if (query.isEmpty) {
          emit(SearchInitialState());
        } else {
          emit(NoteLoadingState());
          final results = await _noteRepository.searchNotes(
            event.query,
          );
          emit(NoteLoadedState(notes: results));
        }
      } catch (e) {
        emit(NoteErrorState(message: 'Ошибка изменения заметки'));
      }
    });
  }
}
