import '../entities/issue.dart';

abstract class IssuesRepository {
  Future<List<Issue>> getIssues();

  Future<Issue> getIssue(String number);

  void setVisitedIssue(String issue);

  Future<List<String>> getVisitedIssues();
}
