import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: Color.fromARGB(255, 44, 124, 71),
        onPrimary: Colors.white,
        surface: Color(0xFFF4F7F4),
        onSurface: Color(0xFF191C19),
        surfaceContainerHighest: Color(0xFFE2E9E2),
        onSurfaceVariant: Color(0xFF424942)
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 44, 124, 71),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.robotoSerif(
          textStyle: TextStyle(fontSize: 50, color: Colors.amber),
        )
      ),
      bottomAppBarTheme: BottomAppBarThemeData(
        color: Color(0xFFE2E9E2),
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0)
            )
          ),
          StadiumBorder()
        )
      ),
    );
  }
}