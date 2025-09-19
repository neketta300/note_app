part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NoteInitialState extends NoteState {}

final class NoteLoadingState extends NoteState {}

final class NoteLoadedState extends NoteState {
  final List<Note> notes;

  const NoteLoadedState({required this.notes});

  @override
  List<Object> get props => super.props..addAll(notes);
}

final class NoteEmptyState extends NoteState {}

class SearchInitialState extends NoteState {}

final class NoteErrorState extends NoteState {
  final String message;

  const NoteErrorState({required this.message});

  @override
  List<Object> get props => super.props..add(message);
}
