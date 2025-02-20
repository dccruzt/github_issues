import 'package:equatable/equatable.dart';

import '../../../domain/entities/issue.dart';

class IssueDetailsState extends Equatable {
  const IssueDetailsState({this.issue, this.error});

  final Issue? issue;
  final Object? error;

  IssueDetailsState copyWith({
    Issue? issue,
    Object? error,
  }) =>
      IssueDetailsState(
        issue: issue ?? this.issue,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [issue, error];
}
