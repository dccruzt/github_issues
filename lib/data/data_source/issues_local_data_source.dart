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

  setVisitedIssue(String number) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final issues = prefs.getStringList(_visitedIssues) ?? [];

      if (!issues.contains(number)) {
        prefs.setStringList(_visitedIssues, issues..add(number));
      }
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
