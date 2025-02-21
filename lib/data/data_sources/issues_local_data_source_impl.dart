import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/data_sources/issues_local_data_source.dart';

class IssuesLocalDataSourceImpl implements IssuesLocalDataSource {
  static const _appTheme = 'APP_THEME';
  static const _visitedIssues = 'VISITED_ISSUES';

  @override
  Future<bool> isDarkTheme() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_appTheme) ?? false;
    } catch (_) {
      rethrow;
    }
  }

  @override
  void setDarkTheme(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(_appTheme, value);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getVisitedIssues() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_visitedIssues) ?? [];
    } catch (_) {
      rethrow;
    }
  }

  @override
  void setVisitedIssue(String number) async {
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
}
