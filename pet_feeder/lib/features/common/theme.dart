import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  hintColor: Color.fromARGB(255, 58, 159, 241),
  scaffoldBackgroundColor:
      Color.fromARGB(255, 227, 242, 255), // Background color (light blue)
  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB(255, 23, 148, 250), // Primary color for light theme
    secondary: Color(0xFF64B5F6), // Secondary color for light theme
  ),
);

ThemeData darkTheme = ThemeData.dark();
