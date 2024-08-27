// lib/providers/theme_provider.dart

import 'package:flutter/material.dart';
import '../utils/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;
  int _themeIndex;

  ThemeProvider(this._themeData, this._themeIndex);

  ThemeData get themeData => _themeData;

  int get themeIndex => _themeIndex;

  void setTheme(int index) {
    switch (index) {
      case 0:
        _themeData = AppTheme.lightTheme;
      case 1:
        _themeData = AppTheme.darkTheme;
      case 2:
        _themeData = AppTheme.greenTheme;
      case 3:
        _themeData = AppTheme.redTheme;
      default:
        _themeData = AppTheme.lightTheme;
    }
    _themeIndex = index;
    notifyListeners();
  }

  void nextTheme() {
    int nextIndex = (_themeIndex + 1) % 4; // 4 est le nombre total de thèmes
    setTheme(nextIndex);
  }
}
