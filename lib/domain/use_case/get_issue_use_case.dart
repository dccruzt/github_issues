import '../entity/issue_entity.dart';
import '../repository/issues_repository.dart';

abstract class UseCase<Arg, Result> {
  Future<Result> call(Arg arg);
}

class GetIssueUseCase implements UseCase<int, IssueEntity> {
  GetIssueUseCase({required this.repository});

  final IssuesRepository repository;

  @override
  Future<IssueEntity> call(int arg) {
    try {
      return repository.getIssue(arg);
    } catch (_) {
      rethrow;
    }
  }
}
