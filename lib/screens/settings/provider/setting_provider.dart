import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';

  ThemeMode _currentThemeMode = ThemeMode.system;

  ThemeMode get currentThemeMode => _currentThemeMode;

  bool get isDarkMode => _currentThemeMode == ThemeMode.dark;

  SettingsProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final theme = prefs.getString(_themeKey) ?? 'system';

    switch (theme) {
      case 'light':
        _currentThemeMode = ThemeMode.light;
        break;
      case 'dark':
        _currentThemeMode = ThemeMode.dark;
        break;
      default:
        _currentThemeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _currentThemeMode = mode;

    final prefs = await SharedPreferences.getInstance();

    switch (mode) {
      case ThemeMode.light:
        await prefs.setString(_themeKey, 'light');
        break;

      case ThemeMode.dark:
        await prefs.setString(_themeKey, 'dark');
        break;

      case ThemeMode.system:
        await prefs.setString(_themeKey, 'system');
        break;
    }

    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    if (_currentThemeMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      await setThemeMode(ThemeMode.dark);
    }
  }
}
