import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injection.dart';
import '../../domain/entity/issue_entity.dart';
import '../../domain/use_case/get_issues_use_case.dart';
import '../../domain/use_case/manage_visited_issues_use_case.dart';
import '../widget/filter_dropdown_button.dart';
import '../widget/sort_dropdown_button.dart';

class IssuesCubitProvider extends BlocProvider<IssuesCubit> {
  IssuesCubitProvider({super.key, super.child})
      : super(
            create: (context) => IssuesCubit(
                  getIssuesUseCase: di(),
                  manageVisitedIssuesUseCase: di(),
                )..init());

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
    await getIssues();
    _subscription = manageVisitedIssuesUseCase.stream.listen(
      (event) {
        List<IssueEntity> updatedIssues = List.of(state.issues ?? []);
        state.issues?.asMap().forEach((index, value) {
          if (event.contains(value.number.toString())) {
            updatedIssues[index] = updatedIssues[index].copyWith(visited: true);
          }
        });
        emit(state.copyWith(issues: updatedIssues));

        List<IssueEntity> updatedOriginalIssues =
            List.of(state.originalIssues ?? []);
        state.originalIssues?.asMap().forEach((index, value) {
          if (event.contains(value.number.toString())) {
            updatedOriginalIssues[index] =
                updatedOriginalIssues[index].copyWith(visited: true);
          }
        });
        emit(state.copyWith(originalIssues: updatedOriginalIssues));
      },
      onError: (error, stackTrace) => emit(state.copyWith(error: error)),
    );
  }

  Future<void> getIssues() => getIssuesUseCase
      .call()
      .then(
        (value) => emit(
          state.copyWith(issues: value, originalIssues: value),
        ),
      )
      .catchError((error) => emit(state.copyWith(error: error)));

  void sortIssues(SortBy sortBy) {
    List<IssueEntity> sortedIssues = List.of(state.issues ?? []);

    switch (sortBy) {
      case SortBy.newest:
        sortedIssues.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortBy.oldest:
        sortedIssues.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case SortBy.alphabet:
        sortedIssues.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
    }
    emit(state.copyWith(issues: sortedIssues));
  }

  void filterIssues(FilterBy filterBy) {
    List<IssueEntity>? filteredIssues = List.of(state.originalIssues ?? []);

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
            .where((issue) =>
                (DateTime.now().difference(issue.createdAt).inHours) <= 1)
            .toList();
        break;
      case FilterBy.frameworkLabel:
        filteredIssues = filteredIssues
            .where((issue) =>
                issue.labels != null && issue.labels!.contains('framework'))
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

  final List<IssueEntity>? issues;
  final List<IssueEntity>? originalIssues;
  final Object? error;

  IssuesState copyWith({
    List<IssueEntity>? issues,
    List<IssueEntity>? originalIssues,
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
