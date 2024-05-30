import 'package:flutter/material.dart';
import 'package:flutter_meals/screens/categories.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 17, 15, 48),
  colorScheme: const ColorScheme.highContrastDark(
    surface: Color.fromARGB(255, 24, 34, 93),
  ),
  textTheme: GoogleFonts.ebGaramondTextTheme().apply(bodyColor: Colors.white),
);

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      home: const CategoriesScreen(),
    ),
  );
}
