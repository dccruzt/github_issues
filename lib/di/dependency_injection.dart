import 'package:get_it/get_it.dart';

import '../core/mapper.dart';
import '../data/data_source/issues_local_data_source.dart';
import '../data/data_source/issues_remote_data_source.dart';
import '../data/repository/issues_repository_impl.dart';
import '../domain/repository/issues_repository.dart';
import '../domain/use_case/get_issue_use_case.dart';
import '../domain/use_case/get_issues_use_case.dart';
import '../domain/use_case/manage_visited_issues_use_case.dart';

GetIt get di => GetIt.instance;

Future<void> initDependencies() async {
  di.registerFactory<Mapper>(() => MapperImpl());

  di.registerFactory(() => IssuesRemoteDataSource());

  di.registerFactory(() => IssuesLocalDataSource());

  di.registerFactory<IssuesRepository>(() => IssuesRepositoryImpl(
        remoteDataSource: di(),
        localDataSource: di(),
        mapper: di(),
      ));

  di.registerFactory(() => GetIssuesUseCase(repository: di()));

  di.registerFactory(() => GetIssueUseCase(repository: di()));

  di.registerLazySingleton(() => ManageVisitedIssuesUseCase(repository: di()));
}
