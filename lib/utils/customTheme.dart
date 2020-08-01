import 'package:flutter/material.dart';

class CustomTheme {
  Color _white = Color(0xFFF5F5F5);
  Color _lightBlue = Colors.blue[50];
  Color _blue = Colors.blue[900];
  Color _red = Colors.red[700];

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _white,
      primaryColor: _blue,
      accentColor: _red,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: _blue),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _blue,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        textTheme: ButtonTextTheme.primary,
        disabledColor: _lightBlue,
      ),
      appBarTheme: AppBarTheme(
        color: _blue,
        elevation: 12,
      ),
      snackBarTheme: SnackBarThemeData(
          // behavior: SnackBarBehavior.floating,
          actionTextColor: Colors.white,
          backgroundColor: _red,
          contentTextStyle: TextStyle(fontSize: 18)),
    );
  }
}
