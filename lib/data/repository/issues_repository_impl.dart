import '../../core/mapper.dart';
import '../../domain/entity/issue_entity.dart';
import '../../domain/repository/issues_repository.dart';
import '../data_source/issues_local_data_source.dart';
import '../data_source/issues_remote_data_source.dart';

class IssuesRepositoryImpl implements IssuesRepository {
  IssuesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.mapper,
  });

  final IssuesRemoteDataSource remoteDataSource;
  final IssuesLocalDataSource localDataSource;
  final Mapper mapper;

  @override
  Future<List<IssueEntity>> getIssues() async {
    try {
      final issues = await remoteDataSource.getIssues();
      return issues
          .map((e) => mapper.mapToIssueEntity(e))
          .toList(growable: false);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<IssueEntity> getIssue(int number) async {
    try {
      final issue = await remoteDataSource.getIssue(number);
      return mapper.mapToIssueEntity(issue);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getVisitedIssues() async {
    try {
      return await localDataSource.getVisitedIssues();
    } catch (_) {
      rethrow;
    }
  }

  @override
  setVisitedIssues(List<String> issues) {
    try {
      localDataSource.setVisitedIssues(issues);
    } catch (_) {
      rethrow;
    }
  }
}
