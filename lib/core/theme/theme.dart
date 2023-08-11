import 'package:flutter/material.dart';
import 'package:task_crud/core/constants/database_variable.dart';

import '/core/hive_helper.dart';
import '../help_functions.dart';

class AppTheme with ChangeNotifier {
  final HiveHelper hive = HiveHelper();
  final DatabaseVariables _databaseVariables = DatabaseVariables.instance;
  bool _isDark = false;
  static const Color primary = Color(0xff181743);
  static const Color black = Colors.black;
  static const String _latoFontFamily = "lato";
  static const String _baloFontFamily = "baloo";

  AppTheme() {
    loadFromPrefs();
  }

  ThemeMode currentTheme() {
    loadFromPrefs();
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _isDark = !_isDark;
    _saveToPrefs();
    notifyListeners();
  }

  loadFromPrefs() async {
    _isDark = hive.getStringFromTheme(_databaseVariables.themeBox);
    notifyListeners();
  }

  _saveToPrefs() async {
    try {
      await hive.saveAboutTheme(_databaseVariables.themeBox, _isDark);
    } catch (e, s) {
      error(e, s, hint: e.toString());
    }
  }

  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    buttonColor: primary,
    primaryColor: primary,
    cardColor: Colors.white,
    fontFamily: _latoFontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: primary,
        fontWeight: FontWeight.w400,
        fontFamily: _latoFontFamily,
        fontSize: 20,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      hintStyle: TextStyle(
        color: const Color(0xff474747).withOpacity(0.5),
        fontWeight: FontWeight.w400,
        fontSize: 16,
        fontFamily: _baloFontFamily,
      ),
      labelStyle: const TextStyle(
        color: Color(0xff474747),
        fontWeight: FontWeight.w400,
        fontSize: 16,
        fontFamily: _baloFontFamily,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffD9D9D9),
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffD9D9D9),
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffD9D9D9),
          )),
    ),
    dialogBackgroundColor: Colors.white,
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: black,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        fontFamily: _latoFontFamily,
        height: 1.5,
      ),
      contentTextStyle: TextStyle(
        color: black,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        fontFamily: _latoFontFamily,
        height: 1.5,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(
        color: primary,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontFamily: _latoFontFamily,
      ),
      bodyMedium: TextStyle(
        color: primary.withOpacity(0.6),
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontFamily: _latoFontFamily,
      ),
      bodySmall: TextStyle(
        color: primary.withOpacity(0.2),
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontFamily: _latoFontFamily,
      ),
      displayLarge: const TextStyle(
        color: primary,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontFamily: _latoFontFamily,
      ),
      displayMedium: const TextStyle(
        color: Color(0xff474747),
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontFamily: _baloFontFamily,
      ),
      headlineLarge: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 20,
        fontFamily: _latoFontFamily,
      ),
      headlineMedium: TextStyle(
        color: primary.withOpacity(0.8),
        fontWeight: FontWeight.w400,
        fontSize: 12,
        fontFamily: _latoFontFamily,
      ),
    ),
  );
}
