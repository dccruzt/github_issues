import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_issues/core/design_system/components/action_row.dart';
import 'package:github_issues/domain/entity/issue_entity.dart';
import 'package:github_issues/domain/use_case/get_issues_use_case.dart';
import 'package:github_issues/ui/controller/issues_controller.dart';
import 'package:github_issues/ui/page/issues_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import 'issues_page_test.mocks.dart';

class MockIssuesCubit extends MockCubit<IssuesState> implements IssuesCubit {}

class IssuesStateFake extends Fake implements IssuesState {}

@GenerateMocks([GetIssuesUseCase])
void main() {
  late MockIssuesCubit issuesCubit;
  late MockGetIssuesUseCase getIssuesUseCase;

  setUp(() {
    issuesCubit = MockIssuesCubit();
    getIssuesUseCase = MockGetIssuesUseCase();
  });

  setUpAll(() {
    registerFallbackValue(IssuesStateFake());
  });

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

  testWidgets('issues screen renders well', (WidgetTester tester) async {
    when(() => issuesCubit.state).thenReturn(
      IssuesState(issues: issues),
    );

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, widget) => Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MediaQuery(
              data: const MediaQueryData(),
              child: IssuesCubitProvider(
                create: (context) => issuesCubit,
                useCase: getIssuesUseCase,
                child: const IssuesScreen(),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Flutter issue #1'), findsOneWidget);
    expect(find.text('Flutter issue #2'), findsOneWidget);
    expect(find.byType(ActionRow), findsNWidgets(2));
  });
}
