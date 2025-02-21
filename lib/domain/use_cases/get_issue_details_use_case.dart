import '../entities/issue.dart';
import '../repositories/issues_repository.dart';

class GetIssueDetailsUseCase {
  const GetIssueDetailsUseCase({required this.repository});

  final IssuesRepository repository;

  Future<Issue> call(String arg) {
    try {
      return repository.getIssueDetails(arg);
    } catch (_) {
      rethrow;
    }
  }
}
