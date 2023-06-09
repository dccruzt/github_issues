import 'package:flutter_test/flutter_test.dart';
import 'package:github_issues/domain/entity/issue_entity.dart';
import 'package:github_issues/domain/repository/issues_repository.dart';
import 'package:github_issues/domain/use_case/get_issues_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_issues_use_case_test.mocks.dart';

@GenerateMocks([IssuesRepository])
void main() {
  final repository = MockIssuesRepository();
  final useCase = GetIssuesUseCase(repository: repository);

  List<IssueEntity> issues = [
    IssueEntity(
      id: 1,
      number: 1090,
      title: 'Flutter issue #1',
      createdAt: DateTime.now(),
      author: 'dccruzt',
      visited: false,
    ),
    IssueEntity(
      id: 2,
      number: 1091,
      title: 'Flutter issue #2',
      createdAt: DateTime.now(),
      author: 'user.test',
      visited: false,
    ),
  ];

  test('should call getIssues method', () async {
    when(repository.getIssues()).thenAnswer((_) async => []);

    await useCase.call();

    verify(repository.getIssues()).called(1);
  });

  test('should return issues list', () async {
    when(repository.getIssues()).thenAnswer((_) async => issues);

    final result = await useCase.call();

    expect(result, issues);
  });
}
