import 'package:flutter/material.dart';
import 'package:posty/services/prefs_service.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';

  LanguageProvider() {
    loadLanguage();
  }

  void loadLanguage() {
    final isEnglish = PrefsService.isEnglish();
    currentLanguage = isEnglish ? 'en' : 'ar';
    notifyListeners();
  }

  Future<void> changeLanguage(String language) async {
    currentLanguage = language;
    await PrefsService.setEnglish(language == 'en');
    notifyListeners();
  }
}
