import 'package:flutter/material.dart';
import 'package:flutter_meals/screens/categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    const ProviderScope(child: App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const CategoriesScreen(),
    );
  }
}
