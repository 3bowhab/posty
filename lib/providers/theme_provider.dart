import 'package:flutter/material.dart';
import 'package:posty/services/prefs_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentMode = ThemeMode.system;

  ThemeProvider() {
    loadTheme();   
  }

  Future<void> loadTheme() async {
    final isDark = await PrefsService.isDarkMode();
    currentMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme(ThemeMode theme) async {
    currentMode = theme;
    await PrefsService.setDarkMode(theme == ThemeMode.dark);
    notifyListeners();
  }
}
