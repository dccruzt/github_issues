import '../entity/issue_entity.dart';

abstract class IssuesRepository {
  Future<List<IssueEntity>> getIssues();

  Future<IssueEntity> getIssue(int number);

  setVisitedIssue(String issue);

  Future<List<String>> getVisitedIssues();
}
