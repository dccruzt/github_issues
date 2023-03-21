import 'package:flutter/material.dart';

import '../data/data_source/issues_local_data_source.dart';
import '../di/dependency_injection.dart';

class ThemeProvider with ChangeNotifier {
  IssuesLocalDataSource localDataSource = di();
  bool _currentTheme = false;

  bool get isDark => _currentTheme;

  set isDark(bool value) {
    _currentTheme = value;
    localDataSource.setDarkTheme(value);
    notifyListeners();
  }
}
