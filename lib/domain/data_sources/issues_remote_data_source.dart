import '../../data/dtos/issue_dto.dart';

abstract class IssuesRemoteDataSource {
  Future<List<IssueDTO>> getIssues();

  Future<IssueDTO> getIssue(String number);
}
