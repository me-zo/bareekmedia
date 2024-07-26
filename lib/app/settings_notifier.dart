import 'package:bareekmedia/app/themes.dart';
import 'package:bareekmedia/core/dependency_registrar/dependencies.dart';
import 'package:bareekmedia/core/fixtures/language_codes.dart';
import 'package:bareekmedia/core/fixtures/theme_codes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends ChangeNotifier {
  static SharedPreferences get _preferences => sl.get<SharedPreferences>();

  //#region language

  void setLocale(String languageCode) {
    _preferences.setString(LanguageCodes.preferencesKey, languageCode);
    notifyListeners();
  }

  Locale get getLocale {
    String code = _preferences.getString(LanguageCodes.preferencesKey) ??
        LanguageCodes.english;
    return _selectLocale(code);
  }

  static Locale _selectLocale(String languageCode) {
    switch (languageCode) {
      case LanguageCodes.arabic:
        return const Locale(LanguageCodes.arabic);
      case LanguageCodes.english:
        return const Locale(LanguageCodes.english);
      default:
        return const Locale(LanguageCodes.english);
    }
  }

//#endregion

  //#region theme

  void setTheme(String theme) {
    _preferences.setString(ThemeCodes.preferencesKey, theme);
    notifyListeners();
  }

  ThemeData get getTheme {
    String code =
        _preferences.getString(ThemeCodes.preferencesKey) ?? ThemeCodes.dark;
    return _selectTheme(code);
  }

  String get getThemeName =>
      _preferences.getString(ThemeCodes.preferencesKey) ?? ThemeCodes.dark;

  static ThemeData _selectTheme(String themeCode) {
    switch (themeCode) {
      case ThemeCodes.dark:
        return Themes.darkTheme;
      case ThemeCodes.light:
        return Themes.lightTheme;
      default:
        return Themes.darkTheme;
    }
  }

//#endregion
}
