import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:notes_app/repositories/note/model/note.dart';
import 'package:path_provider/path_provider.dart';

part 'note_database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 80)();
  TextColumn get body => text()();
  DateTimeColumn get createAt => dateTime()();
  IntColumn get colorValue =>
      integer().withDefault(Constant(0xFFFFFFFF))();
}

@DriftDatabase(tables: [Notes])
class NoteDatabase extends _$NoteDatabase {
  NoteDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Note>> watchAllNote() => select(notes).watch();

  Future<List<Note>> getAllNotes() => select(notes).get();

  Future<int> addNote(NotesCompanion note) =>
      into(notes).insert(note);

  Future<bool> updateNote(Note note) => update(notes).replace(note);

  Future<int> deleteNote(int id) =>
      (delete(notes)..where((tbl) => tbl.id.equals(id))).go();

  Future<Note?> getNoteById(int id) => (select(
    notes,
  )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<List<Note>> searchNotes(String query) {
    final lowerQuery = query.toLowerCase();
    return (select(notes)..where(
          (tbl) =>
              tbl.title.lower().like(lowerQuery) |
              tbl.body.lower().like(lowerQuery),
        ))
        .get();
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'note_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
