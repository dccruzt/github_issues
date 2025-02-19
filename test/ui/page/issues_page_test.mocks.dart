// Mocks generated by Mockito 5.4.4 from annotations
// in github_issues/test/ui/page/issues_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:github_issues/domain/entity/issue_entity.dart' as _i5;
import 'package:github_issues/domain/repository/issues_repository.dart' as _i2;
import 'package:github_issues/domain/use_case/get_issues_use_case.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIssuesRepository_0 extends _i1.SmartFake
    implements _i2.IssuesRepository {
  _FakeIssuesRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetIssuesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetIssuesUseCase extends _i1.Mock implements _i3.GetIssuesUseCase {
  MockGetIssuesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IssuesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIssuesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IssuesRepository);

  @override
  _i4.Future<List<_i5.IssueEntity>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue:
            _i4.Future<List<_i5.IssueEntity>>.value(<_i5.IssueEntity>[]),
      ) as _i4.Future<List<_i5.IssueEntity>>);
}
