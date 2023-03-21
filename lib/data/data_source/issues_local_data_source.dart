import 'package:shared_preferences/shared_preferences.dart';

class IssuesLocalDataSource {
  static const appTheme = 'APP_THEME';

  setDarkTheme(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(appTheme, value);
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> isDarkTheme() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(appTheme) ?? false;
    } catch (_) {
      rethrow;
    }
  }
}
