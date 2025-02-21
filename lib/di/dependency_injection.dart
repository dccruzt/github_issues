import 'package:get_it/get_it.dart';

import '../core/mapper.dart';
import '../data/data_sources/issues_local_data_source_impl.dart';
import '../data/data_sources/issues_remote_data_source.dart';
import '../data/repositories/issues_repository_impl.dart';
import '../domain/data_sources/issues_local_data_source.dart';
import '../domain/data_sources/issues_remote_data_source.dart';
import '../domain/repositories/issues_repository.dart';
import '../domain/use_cases/get_issue_use_case.dart';
import '../domain/use_cases/get_issues_use_case.dart';
import '../domain/use_cases/manage_visited_issues_use_case.dart';

GetIt get di => GetIt.instance;

Future<void> initDependencies() async {
  di.registerFactory<Mapper>(() => MapperImpl());

  di.registerFactory<IssuesRemoteDataSource>(
    () => IssuesRemoteDataSourceImpl(),
  );

  di.registerFactory<IssuesLocalDataSource>(() => IssuesLocalDataSourceImpl());

  di.registerFactory<IssuesRepository>(
    () => IssuesRepositoryImpl(
      remoteDataSource: di(),
      localDataSource: di(),
      mapper: di(),
    ),
  );

  di.registerFactory(() => GetIssuesUseCase(repository: di()));

  di.registerFactory(() => GetIssueDetailsUseCase(repository: di()));

  di.registerLazySingleton(() => ManageVisitedIssuesUseCase(repository: di()));
}
