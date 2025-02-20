import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../di/dependency_injection.dart';
import '../../domain/entities/issue.dart';
import '../../domain/use_cases/get_issues_use_case.dart';
import '../../domain/use_cases/manage_visited_issues_use_case.dart';
import '../widgets/filter_dropdown_button.dart';
import '../widgets/sort_dropdown_button.dart';

class IssuesCubitProvider extends BlocProvider<IssuesCubit> {
  IssuesCubitProvider({
    super.key,
    super.child,
    Create<IssuesCubit>? create,
    GetIssuesUseCase? useCase,
  }) : super(
          create: create ??
              (context) => IssuesCubit(
                    getIssuesUseCase: di(),
                    manageVisitedIssuesUseCase: di(),
                  )..init(),
        );

  static IssuesCubit of(BuildContext context) =>
      BlocProvider.of<IssuesCubit>(context);
}

class IssuesCubit extends Cubit<IssuesState> {
  IssuesCubit({
    required this.getIssuesUseCase,
    required this.manageVisitedIssuesUseCase,
  }) : super(const IssuesState());

  final GetIssuesUseCase getIssuesUseCase;
  final ManageVisitedIssuesUseCase manageVisitedIssuesUseCase;

  StreamSubscription<List<String>>? _subscription;

  Future<void> init() async {
    await getIssuesUseCase
        .call()
        .then(
          (value) => emit(
            state.copyWith(issues: value, originalIssues: value),
          ),
        )
        .catchError((error) => emit(state.copyWith(error: error)));
  }

  void setVisitedIssue(String number) {
    manageVisitedIssuesUseCase.set(number);

    final updatedIssues = state.issues?.map((issue) {
      return issue.number == number ? issue.copyWith(visited: true) : issue;
    }).toList();

    final updatedOriginalIssues = state.originalIssues?.map((issue) {
      return issue.number == number ? issue.copyWith(visited: true) : issue;
    }).toList();

    _emit(issues: updatedIssues, originalIssues: updatedOriginalIssues);
  }

  void _emit({
    List<Issue>? issues,
    List<Issue>? originalIssues,
    Object? error,
  }) =>
      emit(
        state.copyWith(
          issues: issues,
          originalIssues: originalIssues,
          error: error,
        ),
      );

  void sortIssues(SortBy sortBy) {
    List<Issue> sortedIssues = List.of(state.issues ?? []);

    switch (sortBy) {
      case SortBy.newest:
        sortedIssues.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortBy.oldest:
        sortedIssues.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case SortBy.alphabet:
        sortedIssues.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
    }
    emit(state.copyWith(issues: sortedIssues, originalIssues: sortedIssues));
  }

  void filterIssues(FilterBy filterBy) {
    List<Issue>? filteredIssues = List.of(state.originalIssues ?? []);

    switch (filterBy) {
      case FilterBy.clear:
        break;
      case FilterBy.moreThan2Comments:
        filteredIssues = filteredIssues
            .where((issue) => issue.comments != null && issue.comments! >= 2)
            .toList();
        break;
      case FilterBy.lastHour:
        filteredIssues = filteredIssues
            .where(
              (issue) =>
                  (DateTime.now().difference(issue.createdAt).inHours) <= 1,
            )
            .toList();
        break;
      case FilterBy.frameworkLabel:
        filteredIssues = filteredIssues
            .where(
              (issue) =>
                  issue.labels != null && issue.labels!.contains('framework'),
            )
            .toList();
        break;
    }
    emit(state.copyWith(issues: filteredIssues));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

class IssuesState extends Equatable {
  const IssuesState({this.issues, this.originalIssues, this.error});

  final List<Issue>? issues;
  final List<Issue>? originalIssues;
  final Object? error;

  IssuesState copyWith({
    List<Issue>? issues,
    List<Issue>? originalIssues,
    Object? error,
  }) =>
      IssuesState(
        issues: issues ?? this.issues,
        originalIssues: originalIssues ?? this.originalIssues,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [issues, originalIssues, error];
}
