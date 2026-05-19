import 'package:shared_preferences/shared_preferences.dart';

class PrefsKeys {
  static const String darkModeKey = 'darkMode';
  static const String englishKey = 'english';
}

class PrefsService {
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setDarkMode(bool isDarkMode) async {
    await _prefs.setBool(PrefsKeys.darkModeKey, isDarkMode);
  }

  static bool isDarkMode() {
    return _prefs.getBool(PrefsKeys.darkModeKey) ?? false;
  }

  static Future<void> setEnglish(bool isEnglish) async {
    await _prefs.setBool(PrefsKeys.englishKey, isEnglish);
  }

  static bool isEnglish() {
    return _prefs.getBool(PrefsKeys.englishKey) ?? true;
  }
}
