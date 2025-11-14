import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ExtraColors on ColorScheme {
  Color get secondaryButtonBorder => primary;

  Color get secondaryButtonText => primary;

  Color get destructiveButtonBackground => error;

  Color get destructiveButtonText => onError;
}

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: const Color(0xFF3B62FF),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B62FF)),
    textTheme: GoogleFonts.poppinsTextTheme(
      Theme
          .of(context)
          .textTheme,
    ),

    // 🔹 Primary (default) button style
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B62FF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    // 🔸 Outlined (secondary) button style
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black87, width: 1.5),
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFF3B62FF),
        ),
      ),
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
    ),
  );
}

class ButtonThemes {
  static final destructiveBtnStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.red.shade600,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );

  static ButtonStyle fromElevatedButtonWithColors({required Color bgColor, Color? txtColor}) {
    return ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: txtColor ?? Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
    );
  }

  static get roundedBtnStyle => fromElevatedButtonWithColors(bgColor: const Color(0xFF3B62FF));
}