import '../entities/issue.dart';
import '../repositories/issues_repository.dart';

class GetIssuesUseCase {
  const GetIssuesUseCase({required this.repository});

  final IssuesRepository repository;

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
