import '../../core/mapper.dart';
import '../../domain/data_sources/issues_local_data_source.dart';
import '../../domain/data_sources/issues_remote_data_source.dart';
import '../../domain/entities/issue.dart';
import '../../domain/repositories/issues_repository.dart';

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
  Future<List<Issue>> getIssues() async {
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
  Future<Issue> getIssue(String number) async {
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
  void setVisitedIssue(String issue) {
    try {
      localDataSource.setVisitedIssue(issue);
    } catch (_) {
      rethrow;
    }
  }
}
