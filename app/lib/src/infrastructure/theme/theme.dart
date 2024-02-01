import 'package:flutter/material.dart';

class LotoProTheme {
  static ThemeData get light {
    return ThemeData(
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ).copyWith(
        secondary: Colors.blue[700],
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.blue[600];
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.blue[600];
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.blue[600];
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.blue[600];
          }
          return null;
        }),
      ),
    );
  }
}
