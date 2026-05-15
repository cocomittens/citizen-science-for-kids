import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: Color(0xFF1E5631),
        onPrimary: Colors.white,
        surface: Color(0xFFF4F7F4),
        onSurface: Color(0xFF191C19),
        surfaceContainerHighest: Color(0xFFE2E9E2),
        onSurfaceVariant: Color(0xFF424942)
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF1E5631),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)
          )
        )
      ),
      bottomAppBarTheme: BottomAppBarThemeData(
        color: Color(0xFFE2E9E2),
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0)
            )
          ),
          StadiumBorder()
        )
      ),
    );
  }
}