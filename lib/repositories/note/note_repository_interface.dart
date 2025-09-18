import 'package:notes_app/database/note/note_database.dart';

import 'model/note.dart' hide Note;

abstract interface class NoteRepositoryI {
  Future<List<Note>> getAllNotes();

  Stream<List<Note>> watchAllNotes();

  Future<Note?> getNoteById(int id);

  Future<int> addNote(NotesCompanion note);

  Future<bool> updateNote(Note note);

  Future<int> deleteNote(int id);

  Future<List<Note>> searchNotes(String query);
}
