import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injection.dart';
import '../../domain/entity/issue_entity.dart';
import '../../domain/use_case/get_issues_use_case.dart';

class IssuesCubitProvider extends BlocProvider<IssuesCubit> {
  IssuesCubitProvider({super.key, super.child})
      : super(create: (context) => IssuesCubit(useCase: di())..getIssues());
}

class IssuesCubit extends Cubit<IssuesState> {
  IssuesCubit({required this.useCase}) : super(const IssuesState());

  final GetIssuesUseCase useCase;

  Future<void> getIssues() => useCase
      .call()
      .then((value) => emit(state.copyWith(issues: value)))
      .catchError((error) => emit(state.copyWith(error: error)));
}

class IssuesState extends Equatable {
  const IssuesState({this.issues, this.error});

  final List<IssueEntity>? issues;
  final Object? error;

  IssuesState copyWith({
    List<IssueEntity>? issues,
    Object? error,
  }) =>
      IssuesState(
        issues: issues ?? this.issues,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [issues, error];
}
