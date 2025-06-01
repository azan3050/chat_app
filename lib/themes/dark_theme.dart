import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF383636),         // Light Blue (Accent)
    secondary: Color(0xFF1565C0),       // Deeper Blue
    surface: Color(0xFF121212),         // Dark surfaces
    // ignore: deprecated_member_use
    background: Color(0xFF1E1E1E),      // App background
    error: Color(0xFFEF5350),           // Soft red for errors
    onPrimary: Colors.black,            // Text on primary
    onSecondary: Colors.white,          // Text on secondary
    onSurface: Colors.white70,          // Text on cards/sheets
    // ignore: deprecated_member_use
    onBackground: Colors.white,         // Main text
    onError: Colors.black,              // Text on error
    tertiary: Color(0xFF263238),        // Blue Grey dark
    inversePrimary: Color(0xFF2196F3),  // Bright blue for contrast
  ),
);
