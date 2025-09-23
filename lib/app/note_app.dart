import 'package:flutter/material.dart';
import 'package:notes_app/app/app_config.dart';
import 'package:notes_app/app/app_initializer.dart';
import 'package:notes_app/features/create/view/create_screen.dart';
import 'package:notes_app/features/search/view/search_screen.dart';

import '../features/home/home.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key, required this.appConfig});
  final AppConfig appConfig;

  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      appConfig: appConfig,
      child: MaterialApp(
        title: 'Noter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/create_new_note': (context) =>
              const CreateScreen(editStatus: true),
          '/search_note': (context) => SearchScreen(),
        },
      ),
    );
  }
}
