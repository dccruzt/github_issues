import 'package:equatable/equatable.dart';

import '../../../domain/entities/issue.dart';

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
