import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale appLocale;

  Locale get appLocal => appLocale;
  get fetchLocale async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      appLocale = Locale('en');
      return Null;
    }
    appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (type == Locale("ar")) {
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', 'EG');
    } else {
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
