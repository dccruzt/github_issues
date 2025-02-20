import '../entities/issue.dart';
import '../repositories/issues_repository.dart';

abstract class UseCase<Arg, Result> {
  Future<Result> call(Arg arg);
}

class GetIssueUseCase implements UseCase<String, Issue> {
  GetIssueUseCase({required this.repository});

  final IssuesRepository repository;

  @override
  Future<Issue> call(String arg) {
    try {
      return repository.getIssue(arg);
    } catch (_) {
      rethrow;
    }
  }
}
