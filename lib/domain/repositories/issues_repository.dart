import '../entities/issue.dart';

abstract class IssuesRepository {
  Future<List<Issue>> getIssues();

  Future<Issue> getIssueDetails(String number);

  Future<List<String>> getVisitedIssues();

  void setVisitedIssue(String issue);
}
