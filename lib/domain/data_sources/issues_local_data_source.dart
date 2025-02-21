abstract class IssuesLocalDataSource {
  Future<bool> isDarkTheme();

  void setDarkTheme(bool value);

  Future<List<String>> getVisitedIssues();

  void setVisitedIssue(String number);
}
