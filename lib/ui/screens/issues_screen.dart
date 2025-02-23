import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_routes.dart';
import '../controller/issues/issues_controller.dart';
import '../controller/issues/issues_state.dart';
import '../widgets/issues_row_list.dart';
import '../widgets/theme_switch.dart';
import 'arguments/issue_arguments.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class IssuesScreen extends StatelessWidget {
  const IssuesScreen({
    super.key,
    required this.onThemeChanged,
  });

  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Github issues', style: theme.textTheme.titleLarge),
        actions: [ThemeSwitch(onThemeChanged: onThemeChanged)],
      ),
      body: IssuesCubitProvider(
        child: const IssuesList(),
      ),
    );
  }
}

class IssuesList extends StatelessWidget {
  const IssuesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(
      builder: (context, state) {
        if (state.error != null) {
          return const ErrorScreen();
        }

        if (state.issues != null) {
          return IssuesRowList(
            issuesState: state,
            onTap: (number) => _onTap(context, number),
          );
        }

        return const LoadingScreen();
      },
    );
  }

  void _onTap(BuildContext context, String number) {
    IssuesCubitProvider.of(context).setVisitedIssue(number);

    Navigator.pushNamed(
      context,
      AppRoutes.issueDetail,
      arguments: IssueArguments(number: number),
    );
  }
}
