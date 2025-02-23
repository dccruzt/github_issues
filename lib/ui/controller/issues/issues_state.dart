import 'package:equatable/equatable.dart';

import '../../../domain/entities/issue.dart';
import '../../widgets/filter_dropdown_button.dart';
import '../../widgets/sort_dropdown_button.dart';

class IssuesState extends Equatable {
  const IssuesState({
    this.issues,
    this.originalIssues,
    this.sortBy = SortBy.newest,
    this.filterBy = FilterBy.clear,
    this.error,
  });

  final List<Issue>? issues;
  final List<Issue>? originalIssues;
  final SortBy sortBy;
  final FilterBy filterBy;
  final Object? error;

  IssuesState copyWith({
    List<Issue>? issues,
    List<Issue>? originalIssues,
    SortBy? sortBy,
    FilterBy? filterBy,
    Object? error,
  }) =>
      IssuesState(
        issues: issues ?? this.issues,
        originalIssues: originalIssues ?? this.originalIssues,
        sortBy: sortBy ?? this.sortBy,
        filterBy: filterBy ?? this.filterBy,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        issues,
        originalIssues,
        sortBy,
        filterBy,
        error,
      ];
}
