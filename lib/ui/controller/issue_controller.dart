import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injection.dart';
import '../../domain/entity/issue_entity.dart';
import '../../domain/use_case/get_issue_use_case.dart';

class IssueCubitProvider extends BlocProvider<IssueCubit> {
  IssueCubitProvider({super.key, super.child, required int number})
      : super(
            create: (context) => IssueCubit(
                  useCase: di(),
                  number: number,
                )..getIssue());
}

class IssueCubit extends Cubit<IssueState> {
  IssueCubit({
    required this.useCase,
    required this.number,
  }) : super(const IssueState());

  final GetIssueUseCase useCase;
  final int number;

  Future<void> getIssue() => useCase
      .call(number)
      .then((value) => emit(state.copyWith(issue: value)))
      .catchError((error) => emit(state.copyWith(error: error)));
}

class IssueState extends Equatable {
  const IssueState({this.issue, this.error});

  final IssueEntity? issue;
  final Object? error;

  IssueState copyWith({
    IssueEntity? issue,
    Object? error,
  }) =>
      IssueState(
        issue: issue ?? this.issue,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [issue, error];
}
