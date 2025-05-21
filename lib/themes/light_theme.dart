import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
                primary: Color(0x7BBDC5BC),      // Blue
                secondary: Color(0xFFFFFFFF),     // Light Blue
                surface: Color(0xB3FFFFFF),       // Light Grey Background
                background: Color(0xFFFFFFFF),    // Pure white
                error: Color(0xFFB00020),         // Error Red
                onPrimary: Color(0xFF21C090),      // Text on primary
                onSecondary: Colors.black,        // Text on secondary
                onSurface: Colors.black87,        // Text on surface
                onBackground: Colors.black,       // Text on background
                onError: Colors.white,            // Text on error
                tertiary: Color(0xFFE3F2FD),      // Very light blue (for subtle accents)
                inversePrimary: Color(0xFF1565C0),// Darker blue for contrast
        ),
);
