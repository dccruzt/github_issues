import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_issues/domain/entity/issue_entity.dart';
import 'package:github_issues/domain/use_case/get_issues_use_case.dart';
import 'package:github_issues/domain/use_case/manage_visited_issues_use_case.dart';
import 'package:github_issues/ui/controller/issues_controller.dart';
import 'package:github_issues/ui/widget/filter_dropdown_button.dart';
import 'package:github_issues/ui/widget/sort_dropdown_button.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'issues_controller_test.mocks.dart';

@GenerateMocks([GetIssuesUseCase, ManageVisitedIssuesUseCase])
void main() {
  late MockGetIssuesUseCase getIssuesUseCase;
  late MockManageVisitedIssuesUseCase manageVisitedIssuesUseCase;

  setUp(() {
    getIssuesUseCase = MockGetIssuesUseCase();
    manageVisitedIssuesUseCase = MockManageVisitedIssuesUseCase();
  });

  IssueEntity issue1 = IssueEntity(
    id: 1,
    number: '1090',
    title: 'Flutter issue #1',
    createdAt: DateTime.now(),
    author: 'dccruzt',
    visited: false,
  );

  IssueEntity issue2 = IssueEntity(
    id: 2,
    number: '1091',
    title: 'Flutter issue #2',
    createdAt: DateTime.parse('2023-03-10'),
    author: 'user.test',
    visited: false,
  );

  IssueEntity issue3 = IssueEntity(
    id: 3,
    number: '1092',
    title: 'Flutter issue #3',
    createdAt: DateTime.parse('2022-03-10'),
    author: 'user.test.2',
    visited: false,
  );

  List<IssueEntity> issues = [issue1, issue2, issue3];

  var error = Error();

  group('#validate', () {
    blocTest(
      'should return issues',
      build: () => IssuesCubit(
        getIssuesUseCase: getIssuesUseCase,
        manageVisitedIssuesUseCase: manageVisitedIssuesUseCase,
      ),
      setUp: () =>
          when(getIssuesUseCase.call()).thenAnswer((_) async => issues),
      act: (cubit) => cubit.init(),
      expect: () => [IssuesState(issues: issues, originalIssues: issues)],
      verify: (cubit) => verify(getIssuesUseCase.call()).called(1),
    );

    blocTest(
      'should return error',
      build: () => IssuesCubit(
        getIssuesUseCase: getIssuesUseCase,
        manageVisitedIssuesUseCase: manageVisitedIssuesUseCase,
      ),
      setUp: () =>
          when(getIssuesUseCase.call()).thenAnswer((_) async => throw error),
      act: (cubit) => cubit.init(),
      expect: () => [
        IssuesState(issues: null, error: error),
      ],
    );

    blocTest(
      'should return issues sorted',
      build: () => IssuesCubit(
        getIssuesUseCase: getIssuesUseCase,
        manageVisitedIssuesUseCase: manageVisitedIssuesUseCase,
      ),
      setUp: () =>
          when(getIssuesUseCase.call()).thenAnswer((_) async => issues),
      act: (cubit) async {
        await cubit.init();
        cubit.sortIssues(SortBy.oldest);
      },
      expect: () => [
        IssuesState(
          issues: [issue1, issue2, issue3],
          originalIssues: [issue1, issue2, issue3],
        ),
        IssuesState(
          issues: [issue3, issue2, issue1],
          originalIssues: [issue3, issue2, issue1],
        ),
      ],
      verify: (cubit) => verify(getIssuesUseCase.call()).called(1),
    );

    blocTest(
      'should return issues filtered',
      build: () => IssuesCubit(
        getIssuesUseCase: getIssuesUseCase,
        manageVisitedIssuesUseCase: manageVisitedIssuesUseCase,
      ),
      setUp: () =>
          when(getIssuesUseCase.call()).thenAnswer((_) async => issues),
      act: (cubit) async {
        await cubit.init();
        cubit.filterIssues(FilterBy.lastHour);
      },
      expect: () => [
        IssuesState(
          issues: [issue1, issue2, issue3],
          originalIssues: [issue1, issue2, issue3],
        ),
        IssuesState(
          issues: [issue1],
          originalIssues: [issue1, issue2, issue3],
        ),
      ],
      verify: (cubit) => verify(getIssuesUseCase.call()).called(1),
    );
  });
}
