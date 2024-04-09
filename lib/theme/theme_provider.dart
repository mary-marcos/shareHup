import 'package:flutter/material.dart';
import 'package:share_meal/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData; //method
  set themeData(ThemeData themeDataa) {
    _themeData = themeDataa;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
