import 'package:ampiy_homepage/screens/homeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        iconButtonTheme: const IconButtonThemeData(
          style:
              ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
        ),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          const TextTheme(
            displayMedium: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          const TextTheme(
            displayMedium: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: const Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
