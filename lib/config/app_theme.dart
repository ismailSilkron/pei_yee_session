import 'package:flutter/material.dart';
import 'package:pei_yee_session/config/app_pallete.dart';

class AppTheme {
  static ThemeData lightMode(BuildContext context) {
    return ThemeData.light().copyWith(
      appBarTheme: _appBarTheme(context, Brightness.light),
      colorScheme: ColorScheme.light().copyWith(primary: Colors.black),
      textTheme: _textTheme(context, Brightness.light),
      inputDecorationTheme: _inputDecorationTheme(Brightness.light),
    );
  }

  static ThemeData darkMode(BuildContext context) {
    return ThemeData.dark().copyWith(
      appBarTheme: _appBarTheme(context, Brightness.dark),
      colorScheme: ColorScheme.dark().copyWith(
        primary: Colors.white,
        error: AppPallete.errorColor,
      ),
      textTheme: _textTheme(context, Brightness.dark),
      inputDecorationTheme: _inputDecorationTheme(Brightness.dark),
    );
  }

  static AppBarTheme _appBarTheme(BuildContext context, Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    return AppBarTheme(
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: isDark ? AppPallete.whiteColor : Colors.black,
      ),
    );
  }

  static TextTheme _textTheme(BuildContext context, Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    final Color primaryColor =
        (brightness == Brightness.light)
            ? AppPallete.pinkColor
            : AppPallete.whiteColor;

    return TextTheme(
      titleMedium: TextStyle(
        color: primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleLarge: TextStyle(
        color: primaryColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15,
      ),

      bodyMedium: TextStyle(
        color: isDark ? Colors.white : Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(Brightness brightness) {
    return InputDecorationTheme(
      contentPadding: EdgeInsets.all(17),
      border: _inputBorder(),
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(AppPallete.gradient2),
    );
  }

  static OutlineInputBorder _inputBorder([
    Color color = AppPallete.borderColor,
  ]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 3),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
