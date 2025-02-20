import '../entities/issue.dart';
import '../repositories/issues_repository.dart';

abstract class UseCase<Result> {
  Future<Result> call();
}

class GetIssuesUseCase implements UseCase<List<Issue>> {
  GetIssuesUseCase({required this.repository});

  final IssuesRepository repository;

  @override
  Future<List<Issue>> call() async {
    try {
      final visitedIssues = await repository.getVisitedIssues();
      final issues = await repository.getIssues();

      return issues
          .map(
            (issue) => issue.copyWith(
              visited: visitedIssues.contains(issue.number),
            ),
          )
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}
