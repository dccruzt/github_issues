import '../entity/issue_entity.dart';
import '../repository/issues_repository.dart';

abstract class UseCase<Result> {
  Future<Result> call();
}

class GetIssuesUseCase implements UseCase<List<IssueEntity>> {
  GetIssuesUseCase({required this.repository});

  final IssuesRepository repository;

  @override
  Future<List<IssueEntity>> call() {
    try {
      return repository.getIssues();
    } catch (_) {
      rethrow;
    }
  }
}
