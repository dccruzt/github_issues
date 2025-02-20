import 'package:flutter_test/flutter_test.dart';
import 'package:github_issues/domain/entities/issue.dart';
import 'package:github_issues/domain/repositories/issues_repository.dart';
import 'package:github_issues/domain/use_cases/get_issues_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_issues_use_case_test.mocks.dart';

@GenerateMocks([IssuesRepository])
void main() {
  final repository = MockIssuesRepository();
  final useCase = GetIssuesUseCase(repository: repository);

  List<Issue> issues = [
    Issue(
      id: 1,
      number: '1090',
      title: 'Flutter issue #1',
      createdAt: DateTime.now(),
      author: 'dccruzt',
      visited: true,
    ),
    Issue(
      id: 2,
      number: '1091',
      title: 'Flutter issue #2',
      createdAt: DateTime.now(),
      author: 'user.test',
      visited: false,
    ),
  ];

  List<String> visitedIssues = ['1090'];

  test('should call getIssues method', () async {
    when(repository.getIssues()).thenAnswer((_) async => []);
    when(repository.getVisitedIssues()).thenAnswer((_) async => []);

    await useCase.call();

    verify(repository.getIssues()).called(1);
    verify(repository.getVisitedIssues()).called(1);
  });

  test('should return issues list', () async {
    when(repository.getIssues()).thenAnswer((_) async => issues);
    when(repository.getVisitedIssues()).thenAnswer((_) async => visitedIssues);

    final result = await useCase.call();

    expect(result, issues);
  });
}
