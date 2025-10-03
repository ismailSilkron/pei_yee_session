import 'package:flutter/material.dart';
import 'package:pei_yee_session/config/app_pallete.dart';

class AppTheme {
  static ThemeData lightMode(BuildContext context) {
    return ThemeData.light().copyWith(
      appBarTheme: _appBarTheme(context, Brightness.light),
      textTheme: _textTheme(context, Brightness.light),
    );
  }

  static ThemeData darkMode(BuildContext context) {
    return ThemeData.dark().copyWith(
      appBarTheme: _appBarTheme(context, Brightness.dark),
      textTheme: _textTheme(context, Brightness.dark),
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
        color: isDark ? AppPallete.whiteColor : null,
      ),
    );
  }

  static TextTheme _textTheme(BuildContext context, Brightness brightness) {
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
    );
  }
}
