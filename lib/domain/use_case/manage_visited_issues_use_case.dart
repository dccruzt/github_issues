import 'package:github_issues/domain/repository/issues_repository.dart';
import 'package:rxdart/rxdart.dart';

class ManageVisitedIssuesUseCase {
  ManageVisitedIssuesUseCase({
    required this.repository,
  });

  final IssuesRepository repository;

  late final BehaviorSubject<List<String>> _controller =
      BehaviorSubject.seeded([], onListen: read);

  Stream<List<String>> get stream => _controller.stream.distinct();

  Future<void> read() async {
    try {
      final visitedIssues = await repository.getVisitedIssues();
      _controller.add(visitedIssues);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> set(String number) async {
    try {
      if (_controller.hasValue && !_controller.value.contains(number)) {
        final visitedIssues = [..._controller.value, number];
        _controller.add(visitedIssues);
        repository.setVisitedIssues(visitedIssues);
      }
    } catch (_) {
      rethrow;
    }
  }
}
