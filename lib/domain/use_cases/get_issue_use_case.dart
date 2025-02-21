import '../entities/issue.dart';
import '../repositories/issues_repository.dart';

abstract class UseCase<Arg, Result> {
  Future<Result> call(Arg arg);
}

class GetIssueDetailsUseCase implements UseCase<String, Issue> {
  GetIssueDetailsUseCase({required this.repository});

  final IssuesRepository repository;

  @override
  Future<Issue> call(String arg) {
    try {
      return repository.getIssueDetails(arg);
    } catch (_) {
      rethrow;
    }
  }
}
