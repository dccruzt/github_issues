import 'package:shared_preferences/shared_preferences.dart';

class IssuesLocalDataSource {
  static const _appTheme = 'APP_THEME';
  static const _visitedIssues = 'VISITED_ISSUES';

  setDarkTheme(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(_appTheme, value);
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> isDarkTheme() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_appTheme) ?? false;
    } catch (_) {
      rethrow;
    }
  }

  setVisitedIssues(List<String> issues) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(_visitedIssues, issues);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<String>> getVisitedIssues() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_visitedIssues) ?? [];
    } catch (_) {
      rethrow;
    }
  }
}
