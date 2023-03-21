import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injection.dart';
import '../../domain/entity/issue_entity.dart';
import '../../domain/use_case/get_issues_use_case.dart';
import '../../domain/use_case/manage_visited_issues_use_case.dart';

class IssuesCubitProvider extends BlocProvider<IssuesCubit> {
  IssuesCubitProvider({super.key, super.child})
      : super(
            create: (context) => IssuesCubit(
                  getIssuesUseCase: di(),
                  manageVisitedIssuesUseCase: di(),
                )..init());
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
      },
      onError: (error, stackTrace) => emit(state.copyWith(error: error)),
    );
  }

  Future<void> getIssues() => getIssuesUseCase
      .call()
      .then((value) => emit(state.copyWith(issues: value)))
      .catchError((error) => emit(state.copyWith(error: error)));

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
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
