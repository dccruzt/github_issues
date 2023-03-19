import '../entity/issue_entity.dart';

abstract class IssuesRepository {
  Future<List<IssueEntity>> getIssues();
}
