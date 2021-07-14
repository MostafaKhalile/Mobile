import 'package:flutter/material.dart';
import 'package:techtime/Helpers/themes/dark_theme.dart';
import 'package:techtime/Helpers/themes/light_theme.dart';

import '../enums.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = darkTheme;
  ThemeType _themeType = ThemeType.dark;

  void toggleTheme() {
    if (_themeType == ThemeType.dark) {
      currentTheme = lightTheme;
      _themeType = ThemeType.light;
      return notifyListeners();
    }

    if (_themeType == ThemeType.light) {
      currentTheme = darkTheme;
      _themeType = ThemeType.dark;
      return notifyListeners();
    }
  }
}
