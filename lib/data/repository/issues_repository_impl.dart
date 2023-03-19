import '../../core/mapper.dart';
import '../../domain/entity/issue_entity.dart';
import '../../domain/repository/issues_repository.dart';
import '../data_source/issues_remote_data_source.dart';

class IssuesRepositoryImpl implements IssuesRepository {
  IssuesRepositoryImpl({
    required this.remoteDataSource,
    required this.mapper,
  });

  final IssuesRemoteDataSource remoteDataSource;
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
}
