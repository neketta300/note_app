import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app/app/app_config.dart';
import 'package:notes_app/app/note_app.dart';
import 'package:notes_app/database/note/note_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final db = NoteDatabase();
    final appConfig = _initAppConfig(db);
    runApp(NoteApp(appConfig: appConfig));
  } catch (e) {
    log('Ошибка инициализации конфига');
  }
}

AppConfig _initAppConfig(NoteDatabase noteDatabase) =>
    AppConfig(noteDatabase: noteDatabase);
