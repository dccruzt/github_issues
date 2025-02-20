import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../di/dependency_injection.dart';
import '../../../domain/entities/issue.dart';
import '../../../domain/use_cases/get_issues_use_case.dart';
import '../../../domain/use_cases/manage_visited_issues_use_case.dart';
import '../../widgets/filter_dropdown_button.dart';
import '../../widgets/sort_dropdown_button.dart';
import 'issues_state.dart';

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
    List<Issue> issues = List.of(state.issues ?? []);

    final sortedIssues = switch (sortBy) {
      SortBy.newest => issues
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
      SortBy.oldest => issues
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt)),
      SortBy.alphabet => issues
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        ),
    };

    _emit(issues: sortedIssues, originalIssues: sortedIssues);
  }

  void filterIssues(FilterBy filterBy) {
    List<Issue> issues = List.of(state.originalIssues ?? []);

    final filteredIssues = switch (filterBy) {
      FilterBy.clear => issues,
      FilterBy.moreThan2Comments => issues
          .where((issue) => issue.comments != null && issue.comments! >= 2)
          .toList(),
      FilterBy.lastHour => issues
          .where(
            (issue) =>
                (DateTime.now().difference(issue.createdAt).inHours) <= 1,
          )
          .toList(),
      FilterBy.frameworkLabel => issues
          .where(
            (issue) =>
                issue.labels != null && issue.labels!.contains('framework'),
          )
          .toList(),
    };

    _emit(issues: filteredIssues);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
