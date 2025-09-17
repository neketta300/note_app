import 'package:flutter/material.dart';
import 'package:notes_app/features/create/view/create_screen.dart';

import '../features/home/home.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // scaffoldBackgroundColor: Color(0xff252525),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/create_new_note': (context) => CreateScreen(),
      },
    );
  }
}
