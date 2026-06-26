import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primary = Color(0xffF8774F);
  static const background = Color.fromARGB(255, 255, 255, 255);
  static const surface = Colors.white;

  static const textPrimary = Color(0xff1F1F1F);
  static const textSecondary = Color(0xff7A7A7A);

  static ThemeData light = ThemeData(
    brightness: Brightness.light,

    primaryColor: primary,
    scaffoldBackgroundColor: background,
    canvasColor: background,
    cardColor: surface,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,

    fontFamily: GoogleFonts.poppins().fontFamily,

    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),

      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),

      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      bodyLarge: GoogleFonts.poppins(fontSize: 16, color: textPrimary),

      bodyMedium: GoogleFonts.poppins(fontSize: 14, color: textSecondary),

      bodySmall: GoogleFonts.poppins(fontSize: 12, color: textSecondary),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: surface,
      elevation: 0,
      shadowColor: Colors.transparent,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: false,
      foregroundColor: textPrimary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: primary, width: 1),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        minimumSize: const Size(double.infinity, 54),
      ),
    ),

    dividerColor: const Color(0xffECECEC),

    iconTheme: const IconThemeData(color: textPrimary, size: 22),
  );

  static ThemeData dark = light.copyWith(
    brightness: Brightness.dark,
    splashFactory: NoSplash.splashFactory,

    scaffoldBackgroundColor: const Color(0xFF1C1C1E),
    canvasColor: const Color(0xFF1C1C1E),
    cardColor: const Color(0xFF2C2C2E),
    dividerColor: const Color(0xFF3A3A3C),

    primaryColor: primary,
    bottomAppBarTheme: BottomAppBarThemeData(
      color: const Color(0xFF1C1C1E),
      elevation: 0,
      shadowColor: Colors.transparent,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1C1E),
      elevation: 0,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),

    iconTheme: const IconThemeData(color: Colors.white),

    inputDecorationTheme: light.inputDecorationTheme.copyWith(
      fillColor: const Color(0xFF2C2C2E),
      filled: true,
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color.fromARGB(255, 241, 214, 123),
      ),
      prefixIconColor: const Color(0xFF8E8E93),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),

    elevatedButtonTheme: light.elevatedButtonTheme,

    textTheme: light.textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}
