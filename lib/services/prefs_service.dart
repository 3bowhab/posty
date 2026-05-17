import 'package:shared_preferences/shared_preferences.dart';

class PrefsKeys {
  static const String seenIntroKey = 'seenIntro';
  static const String darkModeKey = 'darkMode';
  static const String englishKey = 'english';
}

class PrefsService {
  static Future<void> setIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.seenIntroKey, true);
  }

  // Check if the user has seen the intro.
  static Future<bool> hasSeenIntro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefsKeys.seenIntroKey) ?? false;
  }

  // Set dark mode preference.
  static Future<void> setDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.darkModeKey, isDarkMode);
  }

  // Get dark mode preference.
  static Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefsKeys.darkModeKey) ?? false;
  }

  // Set language preference.
  static Future<void> setEnglish(bool isEnglish) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.englishKey, isEnglish);
  }

  // Get language preference.
  static Future<bool> isEnglish() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefsKeys.englishKey) ?? true;
  }
} 