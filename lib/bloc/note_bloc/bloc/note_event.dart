part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class AddNoteEvent extends NoteEvent {
  final NotesCompanion note;

  const AddNoteEvent({required this.note});

  @override
  List<Object> get props => super.props..add(note);
}

class LoadNoteEvent extends NoteEvent {}

class DeleteNoteEvent extends NoteEvent {
  final int id;

  const DeleteNoteEvent({required this.id});

  @override
  List<Object> get props => super.props..add(id);
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;

  const UpdateNoteEvent({required this.note});

  @override
  List<Object> get props => super.props..add(note);
}

class SearchNotesEvent extends NoteEvent {
  final String query;

  const SearchNotesEvent({required this.query});
  @override
  List<Object> get props => super.props..add(query);
}

class StartSearchEvent extends NoteEvent {}

class _NotesUpdatedEvent extends NoteEvent {
  final List<Note> notes;
  const _NotesUpdatedEvent(this.notes);

  @override
  List<Object> get props => super.props..addAll(notes);
}
