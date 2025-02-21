import '../repositories/issues_repository.dart';

class ManageVisitedIssuesUseCase {
  const ManageVisitedIssuesUseCase({required this.repository});

  final IssuesRepository repository;

  Future<List<String>> read() async {
    try {
      final visitedIssues = await repository.getVisitedIssues();

      return visitedIssues;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> set(String number) async {
    try {
      repository.setVisitedIssue(number);
    } catch (_) {
      rethrow;
    }
  }
}
