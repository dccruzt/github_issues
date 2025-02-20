import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/dependency_injection.dart';
import '../../../domain/use_cases/get_issue_use_case.dart';
import '../../../domain/use_cases/manage_visited_issues_use_case.dart';
import 'issue_details_state.dart';

class IssueDetailsCubitProvider extends BlocProvider<IssueDetailsCubit> {
  IssueDetailsCubitProvider({super.key, super.child, required String number})
      : super(
          create: (context) => IssueDetailsCubit(
            getIssueUseCase: di(),
            manageVisitedIssuesUseCase: di(),
            number: number,
          )
            ..setIssueAsVisited()
            ..getIssue(),
        );
}

class IssueDetailsCubit extends Cubit<IssueDetailsState> {
  IssueDetailsCubit({
    required this.getIssueUseCase,
    required this.manageVisitedIssuesUseCase,
    required this.number,
  }) : super(const IssueDetailsState());

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
