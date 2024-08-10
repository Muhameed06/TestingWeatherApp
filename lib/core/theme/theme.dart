import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_pallete.dart';

class AppTheme {

  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
          ),
          borderRadius: BorderRadius.circular(12)
  );
 
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      enabledBorder: _border(),
      focusedBorder: _border(const Color.fromARGB(255, 78, 78, 89))
    ),
  );
}
