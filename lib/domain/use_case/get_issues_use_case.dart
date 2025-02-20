import '../entity/issue_entity.dart';
import '../repository/issues_repository.dart';

abstract class UseCase<Result> {
  Future<Result> call();
}

class GetIssuesUseCase implements UseCase<List<IssueEntity>> {
  GetIssuesUseCase({required this.repository});

  final IssuesRepository repository;

  @override
  Future<List<IssueEntity>> call() async {
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
