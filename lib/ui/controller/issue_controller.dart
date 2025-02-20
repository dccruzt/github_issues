import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injection.dart';
import '../../domain/entities/issue.dart';
import '../../domain/use_cases/get_issue_use_case.dart';
import '../../domain/use_cases/manage_visited_issues_use_case.dart';

class IssueCubitProvider extends BlocProvider<IssueCubit> {
  IssueCubitProvider({super.key, super.child, required String number})
      : super(
          create: (context) => IssueCubit(
            getIssueUseCase: di(),
            manageVisitedIssuesUseCase: di(),
            number: number,
          )
            ..setIssueAsVisited()
            ..getIssue(),
        );
}

class IssueCubit extends Cubit<IssueState> {
  IssueCubit({
    required this.getIssueUseCase,
    required this.manageVisitedIssuesUseCase,
    required this.number,
  }) : super(const IssueState());

  final GetIssueUseCase getIssueUseCase;
  final ManageVisitedIssuesUseCase manageVisitedIssuesUseCase;
  final String number;

  void setIssueAsVisited() {
    manageVisitedIssuesUseCase.set(number);
  }

  Future<void> getIssue() => getIssueUseCase
      .call(number)
      .then((value) => emit(state.copyWith(issue: value)))
      .catchError((error) => emit(state.copyWith(error: error)));
}

class IssueState extends Equatable {
  const IssueState({this.issue, this.error});

  final Issue? issue;
  final Object? error;

  IssueState copyWith({
    Issue? issue,
    Object? error,
  }) =>
      IssueState(
        issue: issue ?? this.issue,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [issue, error];
}
