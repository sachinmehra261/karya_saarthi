import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static final lightTextTheme = TextTheme(
    titleLarge: GoogleFonts.montserrat(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    bodyLarge: GoogleFonts.montserrat(fontSize: 16, color: Colors.black),

    bodyMedium: GoogleFonts.montserrat(fontSize: 14, color: Colors.black87),
  );

  static final darkTextTheme = TextTheme(
    titleLarge: GoogleFonts.montserrat(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    bodyLarge: GoogleFonts.montserrat(fontSize: 16, color: Colors.white),

    bodyMedium: GoogleFonts.montserrat(fontSize: 14, color: Colors.white70),
  );
}
