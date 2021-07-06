import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale appLocale;
  Locale get appLocal {
    return appLocale;
  }

  Future<Locale> get fetchLocale async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      
      return appLocale = const Locale('en');
    }
   
    return  appLocale = Locale(prefs.getString('language_code'));
  }

  Future<void> changeLanguage(Locale type) async {
    final prefs = await SharedPreferences.getInstance();
    if (type == const Locale("ar")) {
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', 'EG');
    } else {
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
