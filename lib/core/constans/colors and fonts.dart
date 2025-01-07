import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF172E4E); // Azul escuro
  static const Color secondary = Color(0xFFA6A6A6); // Cinza
  static const Color text = Colors.black; // Preto para fontes
  static const Color background = Colors.white; // Branco para fundo
}

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.text,
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColors.text,
        fontFamily: 'Poppins',
        fontSize: 16,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      labelStyle: TextStyle(color: AppColors.secondary),
    ),
  );
}
