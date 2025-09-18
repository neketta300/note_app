import 'package:notes_app/database/note/note_database.dart';
import 'package:notes_app/repositories/note/note_repository_interface.dart';

class NoteRepository implements NoteRepositoryI {
  final NoteDatabase db;

  NoteRepository({required this.db});

  @override
  Future<int> addNote(NotesCompanion note) => db.addNote(note);

  @override
  Future<int> deleteNote(int id) => db.deleteNote(id);

  @override
  Future<List<Note>> getAllNotes() => db.getAllNotes();

  @override
  Future<Note?> getNoteById(int id) => db.getNoteById(id);
  @override
  Future<List<Note>> searchNotes(String query) =>
      db.searchNotes(query);

  @override
  Future<bool> updateNote(Note note) => db.updateNote(note);

  @override
  Stream<List<Note>> watchAllNotes() => db.watchAllNote();
}
